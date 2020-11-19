local Roact = require(script.Parent.Roact)

local function createHookCapture()
	local currentNode
	local currentHookIndex

	local function createHookInstance(base, node)
		local hookInstance = setmetatable({
			node = node
		}, { __index = base })

		hookInstance:init()

		return hookInstance
	end

	local function createHookRunner(base)
		return function(...)
			assert(currentNode, "Hooks may only be used in a functional component wrapped in hookify()")

			local node = currentNode
			local hookIndex = currentHookIndex

			currentHookIndex += 1

			local hook = node.hooks[hookIndex]

			if hook then
				-- Type check current hook
				assert(hook.__class == base.__class, ("Hook type mismatch (expected %s, got %s). Make sure the useHook call isn't in a loop or conditional!"):format(
					base.__name,
					hook.__name
				))
			else
				-- Create new hook
				hook = createHookInstance(base, node)
				node.hooks[hookIndex] = hook
			end

			return hook:use(...)
		end
	end

	local function startCapture(node)
		currentNode = node
		currentHookIndex = 1
	end

	local function endCapture()
		currentNode = nil
		currentHookIndex = nil
	end

	local function wrapFunctionalComponent(functionalComponent, name)
		local component = Roact.Component:extend(name or "HookifyAnonymous")

		function component:init()
			self.hooks = {}
			self.handlers = {}
		end

		function component:register(handlerName, newHandler)
			assert(handlerName ~= "render", ":render() cannot be registered as a handler")
			assert(handlerName ~= "init", ":init() cannot be registered as a handler")

			local handlerList = self.handlers[handlerName]

			if not handlerList then
				handlerList = {}

				self[handlerName] = function(_, ...)
					for _, handler in ipairs(handlerList) do
						handler(...)
					end
				end

				self.handlers[handlerName] = handlerList
			end

			table.insert(handlerList, newHandler)
		end

		function component:render()
			startCapture(self)
			local element = functionalComponent(self.props)
			endCapture()
			return element
		end

		return component
	end

	return {
		wrapFunctionalComponent = wrapFunctionalComponent,
		createHookRunner = createHookRunner
	}
end

return createHookCapture