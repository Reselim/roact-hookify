local createHookCapture = require(script.createHookCapture)

local StateHook = require(script.StateHook)
local EffectHook = require(script.EffectHook)
local BindingHook = require(script.BindingHook)

local hookCapture = createHookCapture()

return setmetatable({
	hookify = hookCapture.wrapFunctionalComponent,

	-- Hooks API
	createHookRunner = hookCapture.createHookRunner,
	Hook = require(script.Hook),

	-- Builtin hooks
	useState = hookCapture.createHookRunner(StateHook),
	useEffect = hookCapture.createHookRunner(EffectHook),
	useBinding = hookCapture.createHookRunner(BindingHook)
}, {
	__call = function(self, ...)
		return self.hookify(...)
	end
})