local Hook = {}

Hook.__name = "Hook"
Hook.__class = Hook

function Hook:extend(name)
	local class = {}

	for key, value in pairs(Hook) do
		if key ~= "extend" then
			class[key] = value
		end
	end

	class.__name = name
	class.__class = class

	return class
end

return Hook