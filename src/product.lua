--[[
	Multiplies all numbers in the _input_ array.

	If the _input_ has no elements, return `1`.

	@example
		Dash.product({3, 3, 2}) --> 18
]]
local Dash = script.Parent
local reduce = require(Dash.reduce)

--[=[

	(new!)
	
	```lua
	product(input: { number }): number
	```
	
	Multiplies together all of the numbers in the _input_ array.
	
	If the _input_ has no elements, return `1`.
	
	**Example**
	```lua
	Dash.product({3, 3, 2}) --> 18
	```

]=]

local function product(input: { number }): number
	return reduce(input, function(acc, num)
		return acc * num
	end, 1)
end

return product
