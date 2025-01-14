--!strict
--!native
--!optimize 2


-- Class Definition
--[=[
	@class Event

	Event
]=]
local Event = {};
Event.__index = Event;

type Listener<A...> = {
	name: string,
	dependency: any,
	callback: (A...) -> ()
}

type EventOptions = {
	sequential: (boolean|"Print")?,
	providerOnly: boolean?,
}

--[=[
	@within Event

	Event

	@return Event
]=]
function Event.new(name:string, options: EventOptions?) : any
	local self = {
		_listeners = {},
	}

	if options and options.sequential then
		function self:Fire(...: any)
			for listener,_ in self._listeners do
				listener.callback(...)
			end
		end
	end
	
	return setmetatable(self, Event) :: any;
end

--[=[
	@within Event

	Fires the event

	@return Event
]=]
function Event:Fire(...: any)
	for listener,_ in self._listeners do
		task.spawn(listener.callback, ...)
	end
end

--[=[
	@within Event

	Connects a depdency to this event.

	@return Event
]=]
function Event:Connect(dependency: any, callback: () -> ())
	self._listeners[{
		name = getmetatable(dependency).name,
		dependency = dependency,
		callback = callback
	}] = true
end

return Event;