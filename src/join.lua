--[[
	Output a new Map from merging all the keys in the Map arguments in left-to-right order.

	The None symbol can be used to remove existing elements.

	@param ... any number of tables
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local assign = require(Dash.assign)

--[=[

	```lua
	join<Key, Value>(...: Types.Map<Key, Value>): Types.Map<Key, Value>
	```
	
	Output a new [Map](#map) from merging all the keys in the [Map](#map) arguments in left-to-right order.
	
	**Example**
	```lua
	Dash.join(
		{Text = "Hello World!", Color = "Sky Blue"},
		{Title = "Greetings!", Color = "Indigo"}
	)
	
	--[[
	Output: {
		["Color"] = "Indigo",
		["Text"] = "Hello World!",
		["Title"] = "Greetings!"
	}
	]]
	```
	
	**See**
	
	- [Dash.assign](#assign) for a mutable alternative

]=]

local function join<Key, Value>(...: Types.Map<Key, Value>): Types.Map<Key, Value>
	return assign({}, ...)
end

return join
