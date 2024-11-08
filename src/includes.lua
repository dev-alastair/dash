--[[
	Returns `true` if the _item_ exists as a value in the _input_ table.

	A nil _item_ will always return `false`.
]]
--[=[

	```lua
	includes(source: Types.Table, value: any): boolean
	```
	
	Returns _true_ if the _item_ exists as a value in the _source_ [Table](#table).
	
	**Example**
	```lua
	-- Does the table include 100?
	Dash.includes({1, 10, 100, 1000}, 100)
	
	--[[
	Output: true
	]]
	```
	
	**See**
	
	For a stronger version of `Dash.includes`, use [Dash.some](#some).

]=]

local function includes<Item>(input: { [unknown]: Item }, item: Item?): boolean
	if item == nil then
		return false
	end
	for _, child in input do
		if child == item then
			return true
		end
	end
	return false
end

return includes
