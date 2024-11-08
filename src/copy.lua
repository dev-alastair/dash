--[[
	Returns a shallow copy of the _input_ Table.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assign = require(Dash.assign)

--[=[

	```lua
	copy(input: Types.Table): Types.Table
	```
	
	Returns a shallow copy of the _input_ Table.
	
	**Example**
	
	```lua
	Dash.copy({a = 1, b = 3})
	
	--[[
	Output: {
		["a"] = 1,
		["b"] = 3
	}
	]]
	```

]=]

local function copy(input: Types.Table): Types.Table
	return assign({}, input)
end
return copy
