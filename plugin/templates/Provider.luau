return [[
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Harmony = require(ReplicatedStorage.Harmony)
local Provider, Workers = Harmony.Provider, Harmony.Workers

local Methods = {}
local Props = {}

function onInit()

end

function onInit()

end

-- Share methods and props to other modules
local self = Provider.New(script.Name, Methods, Props)
type Self = typeof(self)

Workers.OnInit:Connect(self, onInit)
Workers.OnStart:Connect(self, onInit)

return self

]]

