```lua
local counter = hookify(function()
	local count, setCount = hookify.useState(0)

	return Roact.createElement("TextButton", {
		Text = ("Current count is %d"):format(count),

		[Roact.Event.Activated] = function()
			setCount(count + 1)
		end
	})
end)
```

[Hooks documentation on React](https://reactjs.org/docs/hooks-intro.html)