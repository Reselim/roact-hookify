local Hook = require(script.Parent.Hook)

local EffectHook = Hook:extend("Effect")

function EffectHook:init()
	local function proxy()
		self.handler()
	end

	self.node:register("didMount", proxy)
	self.node:register("didUpdate", proxy)
end

function EffectHook:use(handler)
	self.handler = handler
end

return EffectHook