local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Harmony = require(ReplicatedStorage.Harmony)

local Methods = {}

function Methods.Touched(self:Self, hit: BasePart)
    local humanoid = hit.Parent and hit.Parent:FindFirstAncestorOfClass("Humanoid")
    if humanoid then
        Methods.TakeDamage(self, humanoid)
    end
end

function Methods.TakeDamage(self:Self, humanoid:Humanoid)
    humanoid:TakeDamage(100)
end

local factory = Harmony.Factory(...::BasePart)
    :With(Methods, function()
        return {
            counter = 0
        }
    end)
    :Connect("Touched", Methods.Touched)
    :New()
    :Bind(script.Name)

type Self = typeof(Methods)&{counter:number}&Harmony.Component<BasePart>
return factory