--[[
	Reverse the order of the elements in the _input_ array.
]]

local insert = table.insert

--[=[

	```lua
	reverse<T>(input: { T }): { T }
	```
	
	Reverse the order of the elements in the _input_ array.
	
	**Example**
	```lua
	Dash.reverse({3, 2, 1})
	
	--[[
	Output: {
		[1] = 1,
		[2] = 2,
		[3] = 3
	}
	]]
	```

]=]

local function reverse<T>(input: { T }): { T }
	local output: { T } = {}
	for i = #input, 1, -1 do
		insert(output, input[i])
	end
	return output
end
return reverse
