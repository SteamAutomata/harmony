local Event = require(script.Parent.Event)
local types = require(script.Parent.types)

return {
    OnInit = Event.new("OnInit", {sequential = "Print"})::types.Event<>,
    OnStart = Event.new("OnStart")::types.Event<>,
    Heartbeat = Event.new("Heartbeat")::types.Event<number>,
    PlayerAdded = Event.new("PlayerAdded")::types.Event<Player>,
    PlayerRemoving = Event.new("PlayerRemoving")::types.Event<Player>,
}