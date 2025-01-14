local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Harmony = require(ReplicatedStorage.Harmony)

local Methods = {}

type InstanceType = BasePart
type Self = Harmony.Component<InstanceType> & typeof(Methods) & {
    damageAmount:number
}

function Methods.Touched(self:Self, hit: BasePart)
    local humanoid = hit.Parent and hit.Parent:FindFirstAncestorOfClass("Humanoid")
    if humanoid then
        Methods.TakeDamage(self, humanoid)
    end
end

function Methods.TakeDamage(self:Self, humanoid:Humanoid)
    humanoid:TakeDamage(self.damageAmount)
end

local factory = Harmony.Factory(...::InstanceType)
    :With(Methods, function()
        return {
            damageAmount = 0
        }
    end)
    :Connect("Touched", Methods.Touched)
    :Connect(Harmony.Events.Heartbeat, function(self, dt) --[[ do something every step here ]]  end)
    :New(function(self) 
        self.damageAmount = math.random(1, 100)
    end)
    :Bind(script.Name)


return factory