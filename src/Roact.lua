local container = script.Parent.Parent
local roactModule = container:FindFirstChild("Roact")

if not roactModule then
	error("Hookify failed to find Roact. Did you make sure Roact is in the same folder?")
end

return require(roactModule)