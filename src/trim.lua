--[[
	Remove any whitespace at the start and end of the _input_ string.
]]
--[=[

	```lua
	trim(input: string): string
	```
	
	Remove any whitespace at the start and end of the _input_ string.
	
	**Example**
	```lua
	Dash.trim("\n\t\rhello world   ") --> "hello world"
	```

]=]

local function trim(input: string): string
	return input:match("^%s*(.-)%s*$") :: string
end

return trim
