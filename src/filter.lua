--[[
	Filter the _input_ Table by calling the handler on each `(child, index)` tuple.

	For an array input, the order of elements is prevered in the output.

	The handler should return truthy to preserve the value in the resulting Table.
]]

export type FilterHandler<Key, Value> = (Value, Key) -> boolean

--[=[

	```lua
	type FilterHandler<Key, Value> = (Value, Key) -> boolean
	
	filter<Key, Value>(input: { [Key]: Value }, handler: FilterHandler<Key, Value>): { Value }
	```
	
	Filter the _input_ [Table](#table) by calling the handler on each `(value, key)` tuple.
	
	For an array input, the order of elements is preserved in the output.
	
	The handler should return truthy to preserve the value in the resulting Table.
	
	**Example**
	
	```lua
	-- Take only the elements whose values begin with "r"
	Dash.filter(
		{place = "roblox", packages = "rotriever", ide = "studio"},
		function(word) return Dash.startsWith(word, "r")
	end)
	
	--[[
	Output: {
		[1] = "roblox",
		[2] = "rotriever"
	}
	]]
	```

]=]

local function filter<Key, Value>(input: { [Key]: Value }, handler: FilterHandler<Key, Value>): { Value }
	local result = {}
	for index, child in input do
		if handler(child, index) then
			table.insert(result, child)
		end
	end
	return result
end
return filter
