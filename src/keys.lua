--[[
	Returns an array of the keys in the _input_ Table.

	If the input is an array, ordering is preserved.

	If the input is a Map, elements are returned in an arbitrary order.
]]

local insert = table.insert

--[=[

	```lua
	keys<Key, Value>(input: { [Key]: Value }): { Key }
	```
	
	Returns an array of the keys in the _input_ Table.
	
	If the input is an array, ordering is preserved.
	
	If the input is a Map, elements are keys in an arbitrary order.
	
	**Example**:
	```lua
	Dash.keys({
		Color = "Purple",
		Type = "Fruit",
		Shape = "Round"
	})
	
	--[[
	Output: {
		[1] = "Color",
		[2] = "Type",
		[3] = "Shape"
	}
	]]
	```

]=]

local function keys<Key, Value>(input: { [Key]: Value }): { Key }
	local result = {}
	for key, _ in input do
		insert(result, key)
	end
	return result
end
return keys
