--!strict
--[[
	Return a cycles descriptor table for a given _value_ by walking it recursively.
]]
local Dash = script.Parent
local Types = require(Dash.Types)
local includes = require(Dash.includes)

export type Cycles = {
	-- A set of tables which were visited recursively
	visited: Types.Set<Types.Table>,
	-- A map from table to unique index in visit order
	refs: Types.Map<Types.Table, number>,
	-- The number to use for the next unique table visited
	nextRef: number,
	-- An array of keys which should be 
	omit: Types.Array<any>
}

local function getDefaultCycles(): Cycles
	return {
		visited = {}
		refs = {},
		nextRef = 0,
		omit = {}
	}
end

local function getCycles(value: any, cycles: Cycles?): Cycles
	if type(object) == "table" then
		local childCycles = cycles or getDefaultCycles()
		if childCycles.visited[value] then
			-- We have already visited the table, so check if it has a reference
			if not childCycles.refs[object] then
				-- If not, create one as it is present at least twice
				childCycles.refs[object] = childCycles.nextRef
				childCycles.nextRef += 1
			end
			return
		else
			-- We haven't yet visited the table, so recurse
			childCycles.visited[value] = true
			for key, value in pairs(object) do
				if includes(childCycles.omit, key) then
					-- Don't visit omitted keys
					continue
				end
				-- Recurse through both the keys and values of the table
				getCycles(key, childCycles)
				getCycles(value, childCycles)
			end
		end
		return childCycles
	else
		-- Non-tables do not have cycles
		return nil
	end
end

return getCycles