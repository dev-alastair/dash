return function()
	local Dash = require(script.Parent)
	local first = Dash.first

	describe("first", function()
		it("should find the first element if no handler is provided", function()
			local input = {10, 20, 30, 40}
			local output = first(input)
			assertSnapshot(output)
		end)

		it("should find an element in a table by index", function()
			local input = {10, 20, 30, 40}
			local output = first(input, function(index, value)
				return index > 2
			end)
			assertSnapshot(output)
		end)

		it("should find the first element in a table by value", function()
			local input = {10, 20, 30, 40}
			local output = first(input, function(index, value)
				return value > 20
			end)
			assertSnapshot(output)
		end)

		it("should not find an element which does not exist", function()
			local input = {10, 20, 30, 40}
			local output = first(input, function(index, value)
				return index == 10
			end)
			assertSnapshot(output)
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				first()
			end, [[AssertError: Attempted to call Dash.first with argument #1 of type "nil" not "table"]])
		end)
	end)
end
