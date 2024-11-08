--[[
	Iterates through the elements of the _input_ Table.

	For an array input, the elements are visted in order 1..n.

	For a Map input, the elements are visited in an arbitrary order.

	Calls the _handler_ for each entry and constructs a new Table using the same keys but replacing
	the values with new ones returned from the handler.

	Values returned by _handler_ must be defined.

	@see Dash.collectArray if you want to return nil values.
]]

local Dash = script.Parent
local assertEqual = require(Dash.assertEqual)

export type MapHandler<Key, Value, NewValue> = (Value, Key) -> NewValue

--[=[

	```lua
	type MapHandler<Key, Value, NewValue> = (Value, Key) -> NewValue
	
	map<Key, Value, NewValue>(input: { [Key]: Value }, handler: MapHandler<Key, Value, NewValue>): { [Key]: NewValue }
	```
	
	Iterates through the elements of the _input_ Table.
	
	For an array input, the elements are visted in order 1..n.
	
	For a [Map](#map) input, the elements are visited in an arbitrary order.
	
	Calls the _handler_ for each entry and constructs a new [Table](#table) using the same keys but replacing
	the values with new ones returned from the handler.
	
	Values returned by _handler_ must be defined.
	
	**Example**
	```lua
	-- Map characters to their ASCII
	Dash.map({"a", "b", "c"}, function(char) return string.byte(char) end)
	
	--[[
	Output: {
		[1] = 97,
		[2] = 98,
		[3] = 99
	}
	]]
	```
	
	**See**
	
	- [Dash.collectArray](#collectArray) if you want to return nil values.

]=]

local function map<Key, Value, NewValue>(input: { [Key]: Value }, handler: MapHandler<Key, Value, NewValue>): { [Key]: NewValue }
	local result = {}
	for key, child in input do
		local value = handler(child, key)
		assertEqual(value == nil, false, [[Returned nil from a Dash.map handler]])
		result[key] = value
	end
	return result
end
return map
