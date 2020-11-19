local Roact = require(script.Parent.Roact)
local Hook = require(script.Parent.Hook)

local BindingHook = Hook:extend("Binding")

function BindingHook:use(initialValue)
	if not self.binding then
		self.binding, self.setBinding = Roact.createBinding(initialValue)
	end

	return self.binding, self.setBinding
end

return BindingHook