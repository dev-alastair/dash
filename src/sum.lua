--[[
	Sums all numbers in the _input_ array.

	If the input array has no elements, return `0`.

	@example
		Dash.sum({3, 2, 1}) --> 6
]]
local Dash = script.Parent
local reduce = require(Dash.reduce)

--[=[

	(new!)
	
	```lua
	sum(input: { number }): number
	```
	
	Adds together all of the numbers in the _input_ array.
	
	If the input array has no elements, return `0`.
	
	**Example**
	```lua
	Dash.sum({3, 2, 1}) --> 6
	```

]=]

local function sum(input: { number }): number
	return reduce(input, function(acc, num)
		return acc + num
	end, 0)
end

return sum
