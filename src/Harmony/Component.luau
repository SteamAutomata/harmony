local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local types = require(script.Parent.types)

type Component<I> = types.Component<I>

--[=[
	@class Component

	Components are code attached to instances, relying on CollectionService tags.
	You can get a Component object from a Binding.
]=]
local Component = {}

--[=[
	@within Component

	Creates an object with its set of Methods & Props.
	instanceType argument is currently used because it is not possible to manually type generic function arguments in Luau yet.

	Unlike Providers, self must be used instead of Methods & Props.
	Do NOT expect Methods & Props to be cloned.

	```lua
	-- todo
	```
]=]
function Component.new<P,M,I>(_methods: M&{}, props: P&{})
	local methods:any = _methods
	
	local newComponent = props :: P&M&Component<I>
	newComponent.janitor = Janitor.new()
	newComponent.__enabled = true

	-- Alter the methods table if needed
	if not getmetatable(methods) then
		methods.__index = methods
		methods.type = "Component"
		setmetatable(methods, {__index = Component})
	end

	setmetatable(newComponent::any, methods)
	return newComponent
end

--[=[
	@within Component
	Calls the Janitor and prevents the properties from being changed.
]=]
function Component:Destroy()
	self.trove:Destroy()
	table.freeze(self)
end

--[=[
	@within Component
	If the Component is enabled.
]=]
function Component:IsEnabled()
	return self.__enabled
end

--[=[
	@within Component
	Connects the Component to a Signal or a Lifecycle, automatically adding to the janitor
]=]
function Component:Connect<T,A...>(signal: T&(RBXScriptSignal|types.Event<A...>), callback: (A...) -> ())
	if typeof(signal) == "RBXScriptSignal" then
		self.janitor:Add(signal:Connect(callback))
	elseif typeof(signal) == "table" then
		self.janitor:AddObject(signal:Connect(self, callback), "Disconnect")
	end
end

return Component