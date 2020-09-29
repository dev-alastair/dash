--!strict
local Dash = {}

-- Require and add the Dash functions to the Dash table
for _, fn in pairs(script:FindFirstChild("Source"):GetChildren()) do
	Dash[fn.Name] = require(fn)
end

return Dash