--[[
	Returns a value of the _input_ Table at the _key_ provided.

	If the key is missing, the value is acquired from the _getValue_ handler,
	added to the _input_ Table and returned.
]]

export type GetValueHandler<Key, Value> = ({ [Key]: Value }, Key) -> Value

--[=[

	```lua
	type GetValueHandler<Key, Value> = ({ [Key]: Value }, Key) -> Value
	
	getOrSet<Key, Value>(input: { [Key]: Value }, key: Key, getValue: GetValueHandler<Key, Value>): Value
	```
	
	Returns a value of the _input_ [Table](#table) at the _key_ provided.
	If the key is missing, the value is acquired from the _getValue_ handler,
	added to the _input_ [Table](#table) and returned.
	
	**Examples**
	
	```lua
	Dash.getOrSet(
		{Item = "Gummy Bear", Color = "Lime"},
		"Color",
		function() return "Yellow" end
	)
	
	--[[
	Output: Lime
	]]
	```
	
	```lua
	Dash.getOrSet(
		{Item = "Gummy Bear"},
		"Color",
		function() return "Yellow" end
	)
	
	--[[
	Output: Yellow
	]]
	```

]=]

local function getOrSet<Key, Value>(input: { [Key]: Value }, key: Key, getValue: GetValueHandler<Key, Value>): Value
	if input[key] == nil then
		input[key] = getValue(input, key)
	end
	return input[key]
end
return getOrSet
