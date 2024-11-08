--[[
	Returns the index of the first element in the _input_ array that the handler returns `true` for,
	when passed the `(child, key)` entry.

	Returns nil if no entires satisfy the condition.
]]

export type FindHandler<Value> = (Value, number) -> boolean

--[=[

	```lua
	type FindHandler<Value> = (Value, number) -> boolean
	
	findIndex<Value>(input: { Value }, handler: FindHandler<Value>): number?
	```
	
	Returns the index of the first element in the _input_ array that the handler returns `true` for,
	when passed the `(value, key)` entry.
	
	Returns nil if no entires satisfy the condition.
	
	**Examples**
	
	```lua
	-- Find index of "Clementine" fruit if it exists in the array
	Dash.findIndex(
		{"Apple", "Banana", "Clementine"},
		function(fruit) return fruit == "Clementine" end
	)
	
	--[[
	Output: 3
	]]
	```
	
	```lua
	Dash.findIndex(
		{"Apple", "Banana"},
		function(fruit) return fruit == "Clementine" end
	)
	
	--[[
	Output: nil
	]]
	```

]=]

local function findIndex<Value>(input: { Value }, handler: FindHandler<Value>): number?
	for key, child in ipairs(input) do
		if handler(child, key) then
			return key
		end
	end
	return nil
end
return findIndex
