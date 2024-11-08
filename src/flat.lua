--[[
	Flattens the input array by a single level.

	Outputs a new array of elements merged from the _input_ array arguments in left-to-right order.
]]
local Dash = script.Parent
local append = require(Dash.append)
local forEach = require(Dash.forEach)

-- TODO Luau: Support function generics
--[=[

	```lua
	flat(input: { any }): { any }
	```
	
	Flattens the input array by a single level.
	Outputs a new array of elements merged from the _input_ array arguments in left-to-right order.
	
	**Example**
	
	```lua
	-- Flatten a partition of numbers in the range 1-5
	Dash.flat({
		{1, 2, 3},
		{4, 5}
	})
	
	--[[
	Output:  {
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5
	}
	]]
	```

]=]

local function flat(input: { any }): { any }
	local result = {}
	forEach(input, function(childArray: { any })
		append(result, childArray)
	end)
	return result
end

return flat
