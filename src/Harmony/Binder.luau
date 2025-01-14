local CollectionService = game:GetService("CollectionService")
local types = require(script.Parent.types)

--[=[
	@class Binding
]=]
local Binding = {
	_bindings = {},
}
Binding.__index = Binding

function Binding.new<C,I>(tag:string, ctor: (instance: I) -> C&types.Component<I>): types.Binding<C>
	local self = {
		_constructor = ctor,
		_tag = tag,
		_store = {},
	}
	setmetatable(self, Binding)

	CollectionService:GetInstanceAddedSignal(tag):Connect(function(instance)
		self:Add(instance)
	end)
	CollectionService:GetInstanceRemovedSignal(tag):Connect(function(instance)
		self:Remove(instance)
	end)
	for _,instance in CollectionService:GetTagged(tag) do
		self:Add(instance)
	end

	return self::any
end

function Binding.Get(self: types.Binding<any>, instance: Instance)
	return self._store[instance]
end

function Binding.GetAll(self: types.Binding<any>)
	return self._store
end

function Binding:Remove(instance:Instance)
	instance:RemoveTag(self._tag)
	local component = self._store[instance]
	if component then
		if not table.isfrozen(component) then
			component:Destroy()
		end
		self._store[instance] = nil
	end
end

function Binding:Add(instance:Instance)
	instance:AddTag(self._tag)
	if not self._store[instance] then
		self._store[instance] = self._constructor(instance::any)
	end
end

return Binding