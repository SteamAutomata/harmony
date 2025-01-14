--!strict
--!native
--!optimize 2

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local types = require(script.types)

export type Component<I> = types.Component<I>
export type Binding<I,T> = types.Binding<T&Component<I>>

--[=[
	@class Harmony

	The Main class of the module, most classes of Harmony can be accessed from here.

	Bootstrapping on the server:
	```lua
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local RunService = game:GetService("RunService")

	-- Loads ByteNet defs, global state and player state
	require(ReplicatedStorage.Defs)

	local Harmony = require(ReplicatedStorage.Harmony)
		-- Load Services
		:Add(ServerScriptService.Services) 
		-- Load Components
		:Add(ServerScriptService.Components) 
		-- Allow telemetry only in Studio playtesting
		:AllowTelemetry({
			when = function(player: Player) 
				return RunService:IsStudio()
			end
		}) 
		:Init()
	```

	Bootstrapping on the client:
	```lua
	local ReplicatedFirst = game:GetService("ReplicatedFirst")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	require(ReplicatedStorage.Harmony)
		:Add(ReplicatedFirst.Components)
		:Add(ReplicatedFirst.Controllers)
		:Init()
	```
]=]
local Harmony = {
	Provider = require(script.Provider),
	Events = require(script.Events),
	Binder = require(script.Binder),
	Component = require(script.Component),
	Factory = require(script.ComponentFactory) :: types.NewFactory
};
Harmony.__index = Harmony;

local modulesToLoad:{ModuleScript} = {}
local isInit = false
local isStarting = false
local providers = {}

--[=[
	@within Harmony

	Add a ModuleScript or a Folder containing ModuleScripts to Load 

	@param instance ModuleScript|Folder
	@return Harmony
]=]
function Harmony:Add(instance: Instance)
	if instance:IsA("Folder") then
		for _,child in instance:GetChildren() do
			Harmony:Add(child)
		end
		return Harmony
	end
	if instance:IsA("ModuleScript") then
		table.insert(modulesToLoad, instance)
	end
	return Harmony
end

--[=[
	@within Harmony

	Loads all modules, starts lifecycles and mark Harmony as inited

	@return Harmony
]=]
function Harmony:Init()
	if isStarting then
		warn("Harmony is already starting!")
		return Harmony
	end
	isStarting = true

	for _,module in modulesToLoad do
		local prvd = require(module)::any
		if prvd.type == "Provider" then
			table.insert(providers, prvd)
		end
	end
	
	
	Harmony.Events.OnInit:Fire()
	task.wait()
	Harmony.Events.OnStart:Fire()
	RunService.Heartbeat:Connect(function(dt)
		Harmony.Events.Heartbeat:Fire(dt)
	end)
	
	isInit = true
	return Harmony
end

--[=[
	@within Harmony

	Allows defined players to use Telemetry, the callback is invoked each time a player joins

	@return Harmony
]=]
function Harmony:AllowTelemetry(callback: (player:Player) -> boolean)
	Players.PlayerAdded:Connect(function(player)
		if callback(player) then
			print("Allowed telemetry for", player)
			-- TODO: actually Allow telemetry
		end
	end)
	return Harmony
end

--[=[
	@within Harmony

	Currently unused, later used for dependency management ?
]=]
function Harmony:Expect<T>(t: T): T
	return t
end

--[=[
	@within Harmony

	Yields until Harmony is inited.
	Required when using the Framework in a LocalScript or a Script.

	```lua
	local Harmony = require(ReplicatedStorage.Harmony):Wait()
	```

	@return Harmony
]=]
function Harmony:Wait()
	if isInit then
		return Harmony
	end
	while not isInit do
		task.wait()
	end
	return Harmony
end

return Harmony;