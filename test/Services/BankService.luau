local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Harmony = require(ReplicatedStorage.Harmony)

local Props = {
    money = 0,
    debt  = 0
}
local Methods = {}

function Methods.Deposit(amount:number)
    Props.money += amount
end

function Methods.Withdraw(amount:number)
    if amount > Props.money then
        Methods.Loan(amount - Props.money)
    end
    Props.money -= amount
end

function Methods.Loan(amount: number)
    Props.debt += amount
    Props.money += amount
end

return Harmony.Provider.new(script.Name, Methods, Props)
    :Connect(Harmony.Events.OnInit, function()
        print("BankService inited")
    end)
    :Connect(Harmony.Events.OnStart, function()
        print("BankService started")
    end)