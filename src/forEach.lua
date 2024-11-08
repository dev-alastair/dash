--[[
	Iterates through the elements of the _input_ Table.

	If the table is an array, it iterates in order 1..n.

	If the table is a Map, the keys are visited in an arbitrary order.

	Calls the _handler_ for each entry.
]]

export type ForEachHandler<Key, Value> = (Value, Key) -> ()

--[=[

	```lua
	type ForEachHandler<Key, Value> = (Value, Key) -> ()
	
	forEach<Key, Value>(input: { [Key]: Value }, handler: ForEachHandler<Key, Value>)
	```
	
	Iterates through the elements of the _input_ Table.
	
	If the table is an array, it iterates in order 1..n.
	
	If the table is a Map, the keys are visited in an arbitrary order.
	
	Calls the _handler_ for each entry.
	
	**Example**
	```lua
	-- Print all values of table
	Dash.forEach({"Item 1", "Item 2", "Item 3"}, function(value) print(value) end)
	
	--[[
	Output: Item 1
	Item 2
	Item 3
	]]
	```

]=]

local function forEach<Key, Value>(input: { [Key]: Value }, handler: ForEachHandler<Key, Value>)
	for key, value in input do
		handler(value, key)
	end
end
return forEach
