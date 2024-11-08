local Dash = script.Parent
local Types = require(Dash.Types)

type AllHandler = (any, any) -> boolean

local defaultHandler = function(value)
	return value
end

--[=[

	(new!)
	
	```lua
	type AllHandler = (Value, Key) -> boolean
	
	all(input: types.Table, handler: AllHandler?): boolean
	```
	
	Iterates through all elements of the _input_ [Table](#table).
	
	Calls the _handler_ for each entry and returns `false` if the handler returns falsy for any element which it is called with. Otherwise, all elements were truthy so return `true`.
	
	If the handler is not provided, use the truthiness of the values in the table.
	
	**Examples**
	
	```lua
	-- These are the only falsy values in Lua
	Dash.all({nil, false}) --> false
	```
	
	```lua
	Dash.all({true, 0, "0"}) --> true
	```
	
	```lua
	-- Do all words start with 'ro'?
	Dash.all(
		{"roblox", "roact", "rodux"},
		function(word) return Dash.startsWith(word, "ro")
	end)
	--[[
	Output: true
	]]
	
	```

]=]

local function all(input: Types.Table, handler: AllHandler?): boolean
	local allHandler = handler or defaultHandler
	for key, value in input do
		if not allHandler(value, key) then
			return false
		end
	end
	return true
end

return all
