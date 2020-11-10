return function()
	local Dash = require(script.Parent)
	local joinDeep = Dash.joinDeep
	local None = Dash.None

	describe("joinDeep", function()
		it("should join two flat tables", function()
			assertSnapshot(joinDeep({a = 1, c = 4}, {a = 3, b = 2}))
		end)

		it("should deeply join nested tables", function()
			local source = {
				name = "car",
				lights = {
					front = 2,
					back = 2,
					indicators = {
						color = "orange"
					},
					brake = {
						color = "red"
					}
				},
				tyres = 4
			}
			local delta = {
				name = "bike",
				lights = {
					front = 3,
					indicators = {
						rate = 20
					}
				},
				tyres = None
			}
			assertSnapshot(joinDeep(source, delta))
		end)

		it("should not mutate the original input", function()
			local input = {a = 1, b = 2}
			assertSnapshot(joinDeep(input, {a = 3, b = 2}))
			assertSnapshot(input)
		end)

		it("should not clone deep tables that don't change", function()
			local source = {
				name = "car",
				lights = {
					front = 2,
					back = 2,
					indicators = {
						color = "orange"
					},
					brake = {
						color = "red"
					}
				}
			}
			local delta = {
				name = "bike",
				lights = {
					front = 3,
					indicators = {
						rate = 20
					}
				},
				tyres = None
			}
			local result = joinDeep(input, {a = 3, b = 2})
			assertSnapshot(result.lights.brake == source.lights.brake)
		end)
	end)
end
