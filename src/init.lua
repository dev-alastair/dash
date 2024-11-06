local Types = require(script.Types)

export type Array<Value> = Types.Array<Value>
export type Args<Value> = Types.Args<Value>
export type Map<Key, Value> = Types.Map<Key, Value>
export type Set<Key> = Types.Set<Key>
export type Table = Types.Table
export type Class<Object> = Types.Class<Object>
export type AnyFunction = Types.AnyFunction

local Dash = require(script.lib)
Dash = Dash.freeze("Dash", Dash, true)
return Dash
