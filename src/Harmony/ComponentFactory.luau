local Binder = require(script.Parent.Binder)
local Component = require(script.Parent.Component)
local types = require(script.Parent.types)

--[=[
	@class ComponentFactory
]=]
local ComponentFactory = {}
ComponentFactory.__index = ComponentFactory

function ComponentFactory.new(methods, ...)
	local self = {}
	setmetatable(self, ComponentFactory)

	return self
end

--[=[
	@within ComponentFactory

	@return ComponentFactory
]=]
function ComponentFactory:With<M,P>(methods: M&{}, props: () -> P&{})
	self.props = props
	self.methods = methods
	return self
end

--[=[
	@within ComponentFactory

	@return ComponentFactory
]=]
function ComponentFactory:Do<T>(callback: (s:any) -> ())
	self.ctor = callback
	return self
end

--[=[
	@within ComponentFactory

	@return Component
]=]
function ComponentFactory:Bind(name: string)
	return Binder.new(name, function(instance) 
		local component = Component.new(self.methods, self.props)
		component.name = name
		component.me = instance
		self.ctor(component)
		return component
	end)
end

return (setmetatable(ComponentFactory, {__call = ComponentFactory.new})::any)::types.NewFactory