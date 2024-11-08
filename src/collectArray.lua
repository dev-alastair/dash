--[[
	Collect returns a new array derived from _input_ by iterating through its pairs and calling
	the handler on each `(key, child)` tuple.

	The handler should return a new value to be pushed onto the end of the result array, or `nil`
	if no value should be added.
]]

local insert = table.insert

type CollectHandler<Key, Value, NewValue> = (key: Key, value: Value) -> NewValue?

--[=[

	```lua
	type CollectHandler<Key, Value, NewValue> = (key: Key, value: Value) -> NewValue?
	
	collectArray<Key, Value, NewValue>(input: { [Key]: Value }, handler: CollectHandler<Key, Value, NewValue>): { NewValue }
	```
	
	Collect returns a new array derived from _input_ by iterating through its pairs and calling
	the handler on each `(key, value)` tuple.
	
	The handler should return a new value to be pushed onto the end of the result array, or `nil`
	if no value should be added.
	
	**Example**
	
	```lua
	-- Double all elements, ignoring results that are multiples of three
	Dash.collectArray({1, 2, 3, 4, 5, 6}, function(key, value)
		local newValue = value * 2
		return if newValue % 3 == 0 then nil else newValue
	end)
	
	--[[
	Output: {
	[1] = 2,
	[2] = 4,
	[3] = 8,
	[4] = 10
	}
	]]
	```

]=]

local function collectArray<Key, Value, NewValue>(input: { [Key]: Value }, handler: CollectHandler<Key, Value, NewValue>): { NewValue }
	local result = {}
	for key, child in input do
		local outputValue = handler(key, child)
		if outputValue ~= nil then
			insert(result, outputValue)
		end
	end
	return result
end
return collectArray
