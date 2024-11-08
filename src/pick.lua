--[[
	Pick entries in the _input_ Table which should remain in the output by calling the handler on
	each `(child, index)` tuple.

	The handler should return truthy to preserve the value in the resulting Table.
]]

export type PickHandler<Key, Value> = (Value, Key) -> boolean

--[=[

	```lua
	type PickHandler<Key, Value> = (Value, Key) -> boolean
	
	pick<Key, Value>(input: { [Key]: Value }, handler: PickHandler<Key, Value>): { [Key]: Value }
	```
	
	Pick entries in the _input_ Table which should remain in the output by calling the handler on
	each `(child, index)` tuple.
	
	The handler should return truthy to preserve the value in the resulting Table.
	
	**Examples**
	
	```lua
	Dash.pick(
		{10, 20, 30, 40, 50, 60},
		function(value, _) return value % 20 == 0 end
	)
	
	--[[
	Output: {
		[2] = 20,
		[4] = 40,
		[6] = 60
	}
	]]
	```

]=]

local function pick<Key, Value>(input: { [Key]: Value }, handler: PickHandler<Key, Value>): { [Key]: Value }
	local result = {}
	for key, child in input do
		if handler(child, key) then
			result[key] = child
		end
	end
	return result
end
return pick
