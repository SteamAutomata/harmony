--!strict
--!native
--!optimize 2
local Events = require(script.Parent.Events)
local types = require(script.Parent.types)

--[=[
	@class Provider

	A Provider is simply a table with functions and properties that can be required for each. In other words, it is a static class. Because of a Provider just being a static class, not having a constructor, the Luau OOP syntax can't fit.

	There is one ModuleScript per Provider, each containing their properties `Props` and methods `Methods`.
]=]
local Provider = {};
Provider.__index = Provider;

--[=[
	@within Provider

	Creates a Provider named `name` using a sets of `methods` & `props`, the resulting Provider object must not be used in itself.
	
	@return Provider
]=]
function Provider.new<P,M>(name: string, methods: M, props: P): P&M&types.Provider
	local self = props :: P&M&types.Provider

	setmetatable(self::any, {
		__index = setmetatable(methods::any, Provider),
		name=name,
		type="Provider",
		__tostring = function() 
			local fields = {}
			for k,v in pairs(self) do
				table.insert(fields, tostring(k).."="..tostring(v))
			end
			return (getmetatable(self::any).name::any).."{"..table.concat(fields, ",").."}"
		end
	})
	return self
end


--[=[
	@within Provider

	Connects the Provider to a lifecycle Event.

	@return Provider
]=]
function Provider:Connect<T...>(event: types.Event<T...>|RBXScriptSignal|types.SignalLike, callback: (T...) -> ())
	if typeof(event)=="RBXScriptSignal" then
		event:Connect(callback)
	elseif typeof(event)=="table" then
		assert(event.Connect, "Object provided is not like a Signal")
		if event.type == "HarmonyEvent" then
			event:Connect(self, callback)
		else
			event:Connect(callback)
		end
	else
		error("Can't connect a "..typeof(event).." to a component")
	end
	return self
end

--[=[
	@within Provider

	Starts a while loop, invoking the callback every `interval` seconds.
	Will subscribe to OnStart Lifecycle.
	Argument `spawn` describe whenever to call the `callback` through the engine scheduler

	@return Provider
]=]
function Provider:SetInterval(interval: number, spawn: boolean, callback: () -> ())
	self:Connect(Events.OnStart, function()
		while task.wait(interval) do
			if spawn then
				task.spawn(callback)
			else
				callback()
			end
		end
	end)
	return self
end

return Provider;