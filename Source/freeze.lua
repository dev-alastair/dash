--!strict
--[[
	Returns a new read-only view of _object_ which prevents any values from being changed.

	@param name The name of the object for improved error message readability.
	@param throwIfMissing If true then access to a missing key will also throw.
	
	@note
	Unfortunately you cannot iterate using `pairs` or `ipairs` on frozen objects because Luau
	doesn't support defining these custom iterators in metatables.

	@example
	local drink = freeze("Ice Cream", {
		flavor = "mint",
		topping = "sprinkles"
	}, true)
	print(drink.flavor) --> "mint"
	drink.flavor = "vanilla"
	--!> ReadonlyKey: Attempt to write to readonly key "flavor" (a string) of frozen object "Ice Cream"`
	print(drink.syrup) --> nil
	--!> `MissingKey: Attempt to read missing key "syrup" (a string) of frozen object "Ice Cream"`
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local format = require(Dash.format)

local ReadonlyKey = Error.new("ReadonlyKey", "Attempted to write to readonly key {key} (a {keyType}) of frozen object {objectName}")
local MissingKey = Error.new("MissingKey", "Attempted to read missing key {key} (a {keyType}) of frozen object {objectName}")

local function freeze(objectName: string, object: Types.Table, throwIfMissing: boolean?): Types.Table
	-- We create a proxy so that the underlying object is not affected
	local proxy = {}
	setmetatable(
		proxy,
		{
			__index = function(_, key: any)
				local value = object[key]
				if value == nil and throwIfMissing then
					-- Tried to read a key which isn't present in the underlying object
					MissingKey:throw({
						key = tostring(key),
						keyType = typeof(key),
						objectName = objectName
					})
				end
				return value
			end,
			__newindex = function(_, key: any)
				-- Tried to write to any key
				ReadonlyKey:throw({
					key = tostring(key),
					keyType = typeof(key),
					objectName = objectName
				})
			end,
			__len = function()
				return #object
			end,
			__tostring = function()
				return format("Frozen({})", object)
			end,
			__call = function(_, ...)
				return object(...)
			end
		}
	)
	return proxy
end

return freeze