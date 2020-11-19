local Hook = require(script.Parent.Hook)
local Symbol = require(script.Parent.Symbol)

-- Used to track if a state is nil or uninitialized
-- Different from Roact.None
local None = Symbol.named("None")

local function createStateKey()
	return newproxy(true)
end

local StateHook = Hook:extend("State")

function StateHook:init()
	self.key = createStateKey()
end

function StateHook:use(initialValue)
	local state = self.node.state[self.key]

	if state == nil then
		state = initialValue
	elseif state == None then
		state = nil
	end

	local setState = function(newState)
		if newState == nil then
			newState = None
		end

		self.node:setState({
			[self.key] = newState
		})
	end

	return state, setState
end

return StateHook