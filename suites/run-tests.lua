local STATUS_CODE_OK = 0
local STATUS_CODE_ERR = 1

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Packages = ReplicatedStorage:FindFirstChild("Packages")
if not Packages or not Packages:FindFirstChild("Dev") then
	game:GetService("TestService"):Error("Invalid Package configuration. Try running `rotrieve install` to remedy.")
	return STATUS_CODE_ERR
end

local runCLI = require(Packages.Dev.Jest).runCLI

local status, result = runCLI(Packages.Dash, {}, { Packages.Dash }):awaitStatus()

if status == "Rejected" then
	print(result)
	return STATUS_CODE_ERR
end

if status == "Resolved" and result.results.numFailedTestSuites == 0 and result.results.numFailedTests == 0 then
	return STATUS_CODE_OK
end

return STATUS_CODE_ERR