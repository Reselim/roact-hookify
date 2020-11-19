```lua
local counter = hookify(function()
	local count, setCount = hookify.useState(0)

	return Roact.createElement("TextButton", {
		Text = ("Current count is %d"):format(count),
		TextSize = 24,

		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),

		BackgroundTransparency = Color3.new(1, 1, 1),

		[Roact.Event.Activated] = function()
			setCount(count + 1)
		end
	})
end)
```

[Hooks documentation on React](https://reactjs.org/docs/hooks-intro.html)