local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Harmony = require(ReplicatedStorage.Harmony):Wait()
local Killbrick = require(ServerScriptService.Components.Killbrick)
local BankService = require(ServerScriptService.Services.BankService)

BankService.Deposit(100)
BankService.Withdraw(120)

print(BankService.debt) --> 20
print(BankService) --> BankService{money=0,debt=20}
print(getmetatable(BankService::any))

local part = Instance.new "Part"
part.CFrame = CFrame.new(0,50,0)
Killbrick:Add(part)

print(Killbrick:GetAll())