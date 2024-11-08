--[[
	Returns an element in the _input_ Table that the handler returns `true` for, when passed the
	`(child, key)` entry.

	Returns nil if no entires satisfy the condition.

	For an array, this first matching element is returned.

	For a Map, an arbitrary matching element is returned if it exists.
]]

export type FindHandler<Key, Value> = (Value, Key) -> boolean

--[=[

	```lua
	type FindHandler<Key, Value> = (Value, Key) -> boolean
	
	find<Key, Value>(input: { [Key]: Value }, handler: FindHandler<Key, Value>): Value?
	```
	
	Returns an element in the _input_ [Table](#table) that the handler returns `true` for, when passed the
	`(value, key)` entry.
	
	Returns nil if no entires satisfy the condition.
	
	For an array, this first matching element is returned.
	For a Map, an arbitrary matching element is returned if it exists.
	
	**Examples**
	
	```lua
	-- Check if there's the "ExtraSettings" key and get the value of that key if so
	Dash.find(
		{Id = 145, IsReady = false, ExtraSettings = {AutoReady = true}},
		function(value, key) return key == "ExtraSettings" end
	)
	
	--[[
	Output: {
		["AutoReady"] = true
	}
	]]
	
	
	Dash.find({Id = 145, IsReady = false},
		function(value, key) return key == "ExtraSettings" end
	)
	--[[
	Output: nil
	]]
	
	```
	
	
	**See**
	
	- [Dash.first](#first) for a function which returns the first element of an array matching a condition.

]=]

local function find<Key, Value>(input: { [Key]: Value }, handler: FindHandler<Key, Value>): Value?
	for key, child in input do
		if handler(child, key) then
			return child
		end
	end
	return nil
end
return find
