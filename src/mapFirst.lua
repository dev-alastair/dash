--[[
	Iterates through the elements of the _input_ array in order 1..n.

	Calls the _handler_ for each entry and returns the first non-nil value returned by the _handler_.
	If all returned from the _handler_ values are `nil`, `nil` is returned.
]]

export type MapHandler<Value, NewValue> = (Value, number) -> NewValue?

--[=[

	```lua
	type MapHandler<Value, NewValue> = (Value, number) -> NewValue?
	
	mapFirst<Value, NewValue>(input: { Value }, handler: MapHandler<Value, NewValue>): NewValue?
	```
	
	Iterates through the elements of the _input_ array in order 1..n.
	
	Calls the _handler_ for each entry and returns the first non-nil value returned by the _handler_.
	If all returned from the _handler_ values are `nil`, `nil` is returned.
	
	**Example**
	
	```lua
	-- Get first color that's 6 letters and return its first letter
	Dash.mapFirst(
		{"Red", "Yellow", "Orange", "Blue"},
		function(color)
			return if color:len() == 6 then color:sub(1, 1) else nil
		end
	)
	
	--[[
	Output: Y
	]]
	```

]=]

local function mapFirst<Value, NewValue>(input: { Value }, handler: MapHandler<Value, NewValue>): NewValue?
	for index, child in ipairs(input) do
		local output = handler(child, index)
		if output ~= nil then
			return output
		end
	end
	return nil
end
return mapFirst
