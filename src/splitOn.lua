--[[
	Splits _input_ into parts based on a _pattern_ delimiter and returns a Table of the parts,
	followed by a Table of the matched delimiters.
]]
local insert = table.insert

--[=[

	```lua
	splitOn(input: string, pattern: string): { string }
	```
	
	Splits _input_ into parts based on a _pattern_ delimiter and returns a [Table](#table) of the parts,
	followed by a [Table](#table) of the matched delimiters.
	
	**Example**
	
	```lua
	local parts, delimeters = Dash.splitOn(
		"The quick brown fox jumps over the lazy dog",
		" "
	)
	
	print(parts)
	--[[
	Output: {
		[1] = "The",
		[2] = "quick",
		[3] = "brown",
		[4] = "fox",
		[5] = "jumps",
		[6] = "over",
		[7] = "the",
		[8] = "lazy",
		[9] = "dog"
	}
	]]
	
	print(delimeters)
	--[[
	{
		[1] = " ",
		[2] = " ",
		[3] = " ",
		[4] = " ",
		[5] = " ",
		[6] = " ",
		[7] = " ",
		[8] = " "
	}
	]]
	```

]=]

local function splitOn(input: string, pattern: string): { string }
	local parts = {}
	local delimiters = {}
	local from = 1
	if not pattern then
		for i = 1, #input do
			insert(parts, input:sub(i, i))
		end
		return parts
	end
	local delimiterStart, delimiterEnd = input:find(pattern, from)
	while delimiterStart do
		insert(delimiters, input:sub(delimiterStart, delimiterEnd))
		insert(parts, input:sub(from, delimiterStart - 1))
		from = delimiterEnd + 1
		delimiterStart, delimiterEnd = input:find(pattern, from)
	end
	insert(parts, input:sub(from))
	return parts, delimiters
end

return splitOn
