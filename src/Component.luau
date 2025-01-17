local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Janitor = require(script.Parent.Parent.Janitor)
local types = require(script.Parent.types)

type Component<I> = types.Component<I>

--[=[
	@class Component

	Components are code attached to instances, relying on CollectionService tags.
	You can get a Component object from using Binding's methods like Get & GetAll.
]=]
local Component = {}

--[=[
	@within Component
	Used internally, use ComponentFactory
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
	Returns true if the Component is enabled.
]=]
function Component:IsEnabled()
	return self.__enabled
end

--[=[
	@within Component
	Set the enabled state of the component.
]=]
function Component:SetEnabled(enabled: boolean)
	self.__enabled = enabled
	return self.__enabled
end

--[=[
	@within Component
	Connects the Component to a Signal or a Lifecycle, automatically adding to its janitor
]=]
function Component:Connect<T,A...>(signal: T&(RBXScriptSignal|types.Event<A...>), callback: (A...) -> ())
	if typeof(signal) == "string" then
		assert(signal.me[signal], "Can't build")
		self.janitor:Add(signal:Connect(callback))
	elseif typeof(signal)=="RBXScriptSignal" then
		self.janitor:Add(signal:Connect(callback))
	elseif typeof(signal)=="table" then
		self.janitor:AddObject(signal:Connect(self, callback), "Disconnect")
	else
		error("Can't connect a "..typeof(signal).." to a component")
	end
end

return Component