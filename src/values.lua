--[[
	Returns an array of the values in the _input_ Map.

	If the input is an array, ordering is preserved.

	If the input is a Map, elements are returned in an arbitrary order.
]]

local insert = table.insert

--[=[

	```lua
	values<Key, Value>(input: { [Key]: Value }): { Value }
	```
	
	Returns an array of the values in the _input_ Table.
	
	If the input is an array, ordering is preserved.
	
	If the input is a Map, values are returned in an arbitrary order.
	
	**Example**
	```lua
	Dash.values({
		Type = "Cherry",
		Color = "Red",
		Price = "Expensive",
		EnjoymentLevel = "High"
	})
	
	--[[
	Output: {
		[1] = "Red",
		[2] = "Cherry",
		[3] = "High",
		[4] = "Expensive"
	}
	]]
	```

]=]

local function values<Key, Value>(input: { [Key]: Value }): { Value }
	local result: { Value } = {}
	for _, value in input do
		insert(result, value)
	end
	return result
end
return values
