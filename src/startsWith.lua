--[[
	Checks if _input_ starts with the string _start_.
	@example startsWith("Fun Roblox Games", "Fun") --> true
	@example startsWith("Chess", "Fun") --> false
]]
--[=[

	```lua
	startsWith(input: string, prefix: string): boolean
	```
	
	Checks if _input_ starts with the string _start_.
	
	**Examples**
	
	```lua
	startsWith("Fun Roblox Games", "Fun") --> true
	```
	
	```lua
	startsWith("Chess", "Fun") --> false
	```

]=]

local function startsWith(input: string, prefix: string): boolean
	return input:sub(1, prefix:len()) == prefix
end

return startsWith
