--[[
	Build a set from the entries of the _input_ Table, calling _handler_ on each entry and using
	the returned value as an element to add to the set.

	If _handler_ is not provided, values of `input` are used as elements.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

type CollectHandler<Key, Value, NewValue> = (key: Key, value: Value) -> NewValue?

--[=[

	```lua
	type CollectHandler<Key, Value, NewValue> = (key: Key, value: Value) -> NewValue?
	
	collectSet<Key, Value, NewValue>(
		input: { [Key]: Value },
		handler: CollectHandler<Key, Value, NewValue>?
	): Types.Set<Value | NewValue>
	```
	
	Build a set from the entries of the _input_ Table, calling _handler_ on each entry and using
	the returned value as an element to add to the set.
	
	If _handler_ is not provided, values of `input` are used as elements.
	
	
	
	**Examples**
	```lua
	-- Convert array to Set
	Dash.collectSet({"toast", "bagel", "donut"})
	
	--[[
	Output: {
		["bagel"] = true,
		["donut"] = true,
		["toast"] = true
	}
	]]
	```
	
	```lua
	-- Create set of first letters of each word
	Dash.collectSet({"toast", "bagel", "donut", "bread"}, function(key, value)
		return value:sub(1, 1)
	end)
	
	--[[
	Output: {
		["b"] = true,
		["d"] = true,
		["t"] = true
	}
	]]
	```

]=]

local function collectSet<Key, Value, NewValue>(
	input: { [Key]: Value },
	handler: CollectHandler<Key, Value, NewValue>?
): Types.Set<Value | NewValue>
	local result: Types.Set<Value | NewValue> = {}
	for key, child in input do
		local outputValue
		if handler == nil then
			outputValue = child
		else
			outputValue = handler(key, child)
		end
		if outputValue ~= nil then
			result[outputValue] = true
		end
	end
	return result
end
return collectSet
