local Event = require(script.Parent.Event)

return {
    OnInit = Event.new("OnInit", {sequential = "Print"})::Event.Event<>,
    OnStart = Event.new("OnStart")::Event.Event<>,
    Heartbeat = Event.new("Heartbeat")::Event.Event<number>,
    PlayerAdded = Event.new("PlayerAdded")::Event.Event<Player>,
    PlayerRemoving = Event.new("PlayerRemoving")::Event.Event<Player>,
}