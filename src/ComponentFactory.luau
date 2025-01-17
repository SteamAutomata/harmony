local Binder = require(script.Parent.Binder)
local Component = require(script.Parent.Component)
local types = require(script.Parent.types)

--[=[
	@class ComponentFactory

	When using Components, it is necessary to create them through a ComponentFactory. 
	When the Binder sees a new tag added to the Instance Hierarchy, it will create a new Component, adds Props & Methods defined by `With`, execute the constructor defined by `New` and finally, connects defined by `Connect`.
]=]
local ComponentFactory = {}
ComponentFactory.__index = ComponentFactory

function ComponentFactory.new(methods, ...)
	local self = {
		connections = {}
	}
	setmetatable(self, ComponentFactory)

	return self
end

--[=[
	@within ComponentFactory

	Setup Props & Components.
	```lua
	local Methods = {
		DoSomething = function(self) print(self.counter) end
	}

	local function Props()
		return {counter=10}
	end

	-- ...
	:With(Methods, Props)
	```

	@return ComponentFactory
]=]
function ComponentFactory:With<M,P>(methods: M&{}, props: () -> P&{})
	self.props = props
	self.methods = methods
	return self
end

--[=[
	@within ComponentFactory

	Runs the callback on the construction of a component after Props & Methods, but before connections.
	For connecting signals, it's preferred to use `ComponentFactory:Connect`
	```lua
	-- ...
	:New(function(self.me)
		self.me.Transparency = 1
	end)
	```

	@return ComponentFactory
]=]
function ComponentFactory:New<T>(callback: (self:types.Component<Instance>) -> ())
	self.ctor = callback
	return self
end

--[=[
	@within ComponentFactory

	Connects this Component to a Lifecycle or a Signal.
	Will always run AFTER Props & Methods and New
	```lua
	local function callback(self, ...)
		print("Event fired on", self.name, "with arguments", ...)
	end

	-- ...
	:Connect(Harmony.Events.Heartbeat, callback)
	:Connect(workspace.ChildAdded, callback)
	:Connect("Touched", callback) -- Considering the Component attaches to a BasePart
	```

	@return ComponentFactory
]=]
function ComponentFactory:Connect<T...>(
	 event: string|RBXScriptSignal|types.Event<T...>, 
	 callback: (self: types.Component<Instance>, T...) -> ()
)
	self.connections[event] = callback
	return self
end

--[=[
	@within ComponentFactory

	Binds this Factory to a CollectionService tag.

	@return Component
]=]
function ComponentFactory:Bind(tag: string)
	return Binder.new(tag, function(instance: Instance) 
		local component = Component.new(self.methods, self.props)
		component.name = tag
		component.me = instance
		self.ctor(component)
		
		for event,callback in pairs(self.connections) do
			component:Connect(event, callback)
		end
		return component
	end)
end

return (setmetatable(ComponentFactory, {__call = ComponentFactory.new})::any)::types.NewFactory