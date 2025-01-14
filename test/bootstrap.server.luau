local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Harmony = require(ReplicatedStorage.Harmony)

Harmony
    :Add(ServerScriptService.Services)
    :AllowTelemetry(function(_) 
        return true
    end)
    :Init()