local Dash = script.Parent
local class = require(Dash.class)

local _Symbol = class("Symbol", function(name: string)
	return {
		name = name,
	}
end)

function _Symbol:toString(): string
	return ("Symbol(%s)"):format(self.name)
end

export type Symbol = {
	toString: (self: Symbol) -> string,
	name: string,
}

local Symbol = {

	--[[
		Create a symbol with a specified name. Upper snake-case is recommended as the symbol is a
		constant, unless you are linking the symbol conceptually to a different string.

		Symbols are useful when you want a value that isn't equal to any other type, for example if you
		want to store a unique property on an object that won't be accidentally accessed with a simple
		string lookup.

		@example
		local CHEESE = Symbol.new("CHEESE")
		local FAKE_CHEESE = Symbol.new("CHEESE")
		print(CHEESE == CHEESE) --> true
		print(CHEESE == FAKE_CHEESE) --> false
		print(tostring(CHEESE)) --> "Symbol.new(CHEESE)"
	]]

	new = function(name: string): Symbol
		return _Symbol.new(name)
	end,

	isInstance = _Symbol.isInstance,

}

return Symbol
