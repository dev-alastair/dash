--[[
	Collect returns a new Table derived from _input_ by iterating through its pairs and calling
	the handler on each `(key, child)` tuple.

	The handler should return a new `(newKey, value)` tuple to be inserted into the returned Table,
	or `nil` if no value should be added.
]]
local Dash = script.Parent
local Types = require(Dash.Types)

export type CollectHandler<Key, Value, NewKey, NewValue> = (key: Key, value: Value) -> (NewKey?, NewValue?)

--[=[

	```lua
	type CollectHandler = (Key, Value) -> (any, any)?
	
	collect(input: Types.Table, handler: CollectHandler): Types.Map<any, any>
	```
	
	Collect returns a new [Table](#table) derived from _input_ by iterating through its pairs and calling
	the handler on each `(key, value)` tuple.
	
	The handler should return a new `(newKey, value)` tuple to be inserted into the returned Table,
	or `nil` if no value should be added.
	
	**Example**
	
	```lua
	-- Invert keys and values of a table
	Dash.collect({a = "1", b = "2", c = 3}, function(key, value)
		return value, key
	end)
	
	--[[
	Output: {
		[3] = "c"
		["1"] = "a",
		["2"] = "b",
	}
	]]
	```

]=]

local function collect<Key, Value, NewKey, NewValue>(
	input: Types.Map<Key, Value>,
	handler: CollectHandler<Key, Value, NewKey, NewValue>
): Types.Map<NewKey, NewValue>
	local result = {}
	for key, child in input do
		local outputKey, outputValue = handler(key, child)
		if outputKey ~= nil then
			result[outputKey] = outputValue
		end
	end
	return result
end
return collect
