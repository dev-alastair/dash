--[[
	Iterate through the elements of the _input_ array in order 1..n.

	Call the _handler_ for each element, passing the return of the previous call as the first argument.

	The _initial_ value is passed into the first call, and the final value returned by the function.
]]

export type ReduceHandler<Key, Value, Accumulator> = (Accumulator, Value, Key) -> Accumulator

--[=[

	```lua
	type ReduceHandler<Key, Value, Accumulator> = (Accumulator, Value, Key) -> Accumulator
	
	reduce<Key, Value, Accumulator>(
		input: { [Key]: Value },
		handler: ReduceHandler<Key, Value, Accumulator>,
		initial: Accumulator
	): Accumulator
	```
	
	Iterate through the elements of the _input_ [Table](#table), preserving order if it is an array.
	
	Call the _handler_ for each element, passing the return of the previous call as the first argument.
	
	The _initial_ value is passed into the first call, and the final value returned by the function.
	
	**Examples**
	
	```lua
	-- Count occurences of each element in array and output a table of counts
	-- See Dash.frequencies
	Dash.reduce(
		{"Red", "Black", "Red", "Red", "Black"},
		function(acc, color)
			if acc[color] == nil then
				acc[color] = 1
			else
				acc[color] += 1
			end
			return acc
		end, {}
	)
	
	--[[
	Output: {
		["Black"] = 2,
		["Red"] = 3
	}
	]]
	```
	
	```lua
	-- Sum up elements, doubling even indices and halving odd indices
	-- Expected: 0.5 + 4 + 1.5 + 8 + 2.5 = 16.5
	Dash.reduce(
		{1, 2, 3, 4, 5},
		function(acc, num, index)
			return acc + if index % 2 == 0 then num * 2 else num / 2
		end, 0
	)
	--[[
	Output: 16.5
	]]
	```

]=]

local function reduce<Key, Value, Accumulator>(
	input: { [Key]: Value },
	handler: ReduceHandler<Key, Value, Accumulator>,
	initial: Accumulator
): Accumulator
	local result = initial
	for key, value in input do
		result = handler(result, value, key)
	end
	return result
end

return reduce
