--[[
	Adds new elements to the _target_ array from subsequent array arguments in left-to-right order.

	Arguments which are `nil` or None are skipped.

	@mutable target
]]

local Dash = script.Parent
local None = require(Dash.None)
local forEachArgs = require(Dash.forEachArgs)
local forEach = require(Dash.forEach)
local insert = table.insert

--[=[

	```lua
	append<T>(target: { T }, ...: { T }): { T }
	```
	
	Adds new elements to the _target_ array from subsequent array arguments in left-to-right order.
	
	Arguments which are `nil` or None are skipped.
	
	**Example**
	```lua
	Dash.append({1, 2}, {3, 4}, {5})
	
	--[[
	Output: {
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5
	}
	]]
	```

]=]

local function append<T>(target: { T }, ...: { T }?): { T }
	forEachArgs(function(list: { T }?)
		-- TODO (AleksandrSl 29/05/2024): Add wrapper function for this.
		if list == None or list == nil then
			return
		else
			forEach(list, function(value: T)
				insert(target, value)
			end)
		end
	end, ...)
	return target
end

return append
