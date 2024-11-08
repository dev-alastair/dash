--[[
	Iterates through the elements of the _input_ Table in no particular order.

	Calls the _handler_ for each entry and returns `true` if the handler returns truthy for any
	element which it is called with.
]]

export type SomeHandler<Key, Value> = (Value, Key) -> boolean

--[=[

	```lua
	type SomeHandler<Key, Value> = (Value, Key) -> boolean
	
	some<Key, Value>(input: { [Key]: Value }, handler: SomeHandler<Key, Value>): boolean
	```
	
	Iterates through the elements of the _input_ [Table](#table) in no particular order.
	
	Calls the _handler_ for each entry and returns `true` if the handler returns truthy for any
	element which it is called with.
	
	**Example**
	
	```lua
	-- Does there exist a red fruit?
	Dash.some(
		{
			{Type = "Cherry", Color = "Red"},
			{Type = "Strawberry", Color = "Red"},
			{Type = "Blueberry", Color = "Blue"}
		},
		function(fruit) return fruit.Color == "Red" end
	)
	
	--[[
	Output: true
	]]
	```

]=]

local function some<Key, Value>(input: { [Key]: Value }, handler: SomeHandler<Key, Value>): boolean
	for key, child in input do
		if handler(child, key) then
			return true
		end
	end
	return false
end
return some
