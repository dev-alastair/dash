--[[
	Returns the last element in the _input_ array that the handler returns `true` for, when
	passed the `(child, index)` entry.

	Returns nil if no entires satisfy the condition.

	If handler is not defined, the function simply returns the last element of the array.
]]

export type FindHandler<Value> = (Value, number) -> boolean

--[=[

	```lua
	type FindHandler<Value> = (Value, number) -> boolean
	
	last<Value>(input: { Value }, handler: FindHandler<Value>?): Value?
	```
	
	Returns the last element in the _input_ array that the handler returns `true` for, when
	passed the `(value, key)` entry.
	
	Returns nil if no entires satisfy the condition.
	
	If handler is not defined, the function simply returns the last element of the array.
	
	**Examples**
	
	```lua
	Dash.last({3, 2, 1})
	
	--[[
	Output: 1
	]]
	```
	
	```lua
	-- Get last odd number
	Dash.last({4, 3, 2}, function(num) return num % 2 == 1 end)
	
	--[[
	Output: 3
	]]
	```

]=]

local function last<Value>(input: { Value }, handler: FindHandler<Value>?): Value?
	for index = #input, 1, -1 do
		local child = input[index]
		if not handler then
			return child
		end
		if handler and handler(child, index) then
			return child
		end
	end
	return nil
end

return last
