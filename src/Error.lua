local Dash = script.Parent
local Types = require(Dash.Types)
local class = require(Dash.class)
local format = require(Dash.format) :: <T...>(string, T...) -> string
local join = require(Dash.join)

local _Error = class("Error", function(name: string, message: string, tags: Types.Table?)
	return {
		name = name,
		message = message or "An error occurred",
		tags = tags or {},
	}
end)

function _Error:toString(): string
	return format("{}: {}\n{}", self.name, format(self.message, self.tags), self.stack)
end

function _Error:joinTags<Tags>(tags: Tags): Error<Tags>
	return _Error.new(self.name, self.message, join(self.tags, tags or {} :: any))
end

function _Error:throw(tags: Types.Table?)
	local instance = self:joinTags(tags)
	instance.stack = debug.traceback()
	error(instance)
end

type Error<Tags> = {
	toString: (self: Error<Tags>) -> string,
	joinTags: (self: Error<Tags>, tags: Tags?) -> Error<Tags>,
	throw: (self: Error<Tags>, tags: Tags?) -> (),
	name: string,
	message: string,
	tags: Tags,
}

local Error = {

	--[[
		Create a new Error instance.
		@param name The name of the error
		@param string A message for the error which will be formatted using Dash.format
		@param tags Any fixed tags 
	]]

	new = function<Tags>(name: string, message: string, tags: Tags?): Error<Tags>
		return _Error.new(name, message, tags)
	end,

	toString = _Error.toString,

	--[[
		Return a new error instance containing the tags provided joined to any existing tags of the
		current error instance.
	]]
	joinTags = function<Tags>(self: Error<Tags>, tags: Tags): Error<Tags>
		return _Error.joinTags(self, tags)
	end,

	--[[
		Throw an error.

		The stack of the error is captured and stored.

		If additional tags are provided, a new error is created with the joined tags of
		this instance.
	]]
	throw = function<Tags>(self: Error<Tags>, tags: Tags?): ()
		return _Error.throw(self, tags)
	end, 

}

return Error
