--!strict
-- TODO Luau: Support these globally
-- A table with values of type _Value_ and numeric keys 1..n with no gaps
export type Array<Value> = {[number]: Value}
-- A table with values of type _Value_ and numeric keys, possibly with gaps
export type Args<Value> = {[number]: Value}
-- A table with keys of type _Key_ and values of type _Value_
export type Map<Key, Value> = {[Key]: Value}
-- A table with keys of a fixed type _Key_ and a boolean value representing membership of the set (default is false)
export type Set<Key> = {[Key]: boolean}
-- A table with string keys
export type Dictionary<Value> = {[string]: Value}
-- A table of any type
export type Table = {[any]: any}
-- A class has a constructor returning an instance of _Object_ type
export type Class<Object> = {
	new: () -> Object
}
-- A class has a constructor returning an instance of _Object_ type parameterized with _Parameter_
export type GenericClass<Object, Parameter> = {
	new: () -> Object<Parameter>
}

return {}