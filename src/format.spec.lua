return function()
	local Dash = require(script.Parent)
	local format = Dash.format

	describe("format", function()
		it("should format arguments", function()
			assertSnapshot(format("Hello {} please meet {}", "orc", "fate"))
		end)
		it("should format positional arguments", function()
			assertSnapshot(format("Hello {2} please meet {1}", "orc", "fate"))
		end)
		it("should format named arguments", function()
			assertSnapshot(format("Hello {name} please meet {fate}", {name = "orc", fate = "your maker"}))
		end)
		it("should format using a range of display strings", function()
			assertSnapshot(format("Hello {} please meet {}", "orc", 25.7))
			assertSnapshot(format("Hello {} please meet {:06X}", "orc", 255))
			assertSnapshot(format("Hello {} please meet {:?}", "orc", {fate = "your maker"}))
			assertSnapshot(format("Hello {} please meet {:#?}", "orc", {fate = "your maker", achievements = {{made = "you"}}}))
			assertSnapshot(format("Hello {fate:?} please meet {achievements:#?}", {fate = "your maker", achievements = {{made = "you"}}}))
		end)

		it("ensures an input of the correct type", function()
			assertThrows(function()
				format({})
			end, [[AssertError: Attempted to call Dash.format with argument #2 of type "table" not "string"]])
		end)
	end)
end
