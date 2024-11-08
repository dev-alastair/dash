--[[
	Iterates through the elements of the _input_ array in reverse in order n..1.

	Calls the _handler_ for each entry and returns the first non-nil value returned by the _handler_.
	If all returned from the _handler_ values are `nil`, `nil` is returned.
]]

export type MapHandler<Value, NewValue> = (Value, number) -> NewValue?

--[=[

	```lua
	type MapHandler<Value, NewValue> = (Value, number) -> NewValue?
	
	mapLast<Value, NewValue>(input: { Value }, handler: MapHandler<Value, NewValue>): NewValue?
	```
	
	Iterates through the elements of the _input_ array in reverse in order n..1.
	
	Calls the _handler_ for each entry and returns the first non-nil value returned by the handler.
	If all returned from the _handler_ values are `nil`, `nil` is returned.
	
	**Example**
	
	```lua
	-- Get last color that's 6 letters and return its first letter
	Dash.mapLast(
		{"Red", "Yellow", "Orange", "Blue"},
		function(color)
			return if color:len() == 6 then color:sub(1, 1) else nil
		end
	)
	
	--[[
	Output: O
	]]
	```

]=]

local function mapLast<Value, NewValue>(input: { Value }, handler: MapHandler<Value, NewValue>): NewValue?
	for key = #input, 1, -1 do
		local child = input[key]
		local output = handler(child, key)
		if output ~= nil then
			return output
		end
	end
	return nil
end
return mapLast
