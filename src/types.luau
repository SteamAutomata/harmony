local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Janitor = require(script.Parent.Parent.Janitor)

export type Event<A...> = {
	_listeners: {any},
	_currentId: number,
	Fire: (self: Event<A...>, A...) -> (),
	Connect: (self: Event<A...>, dependency: any, callback: (A...) -> ()) -> () -> ()
}

export type SignalLike = {
	Connect: (self: SignalLike, callback: () -> ()) -> ()
}

export type Provider = {
	type: "Provider",
	name: string,
	Connect: <S, T...>(self: S, event: Event<T...>|RBXScriptSignal|SignalLike, callback: (T...) -> ()) -> S,
	SetInterval: <S>(self: S, interval: number, spawn: boolean, callback: () -> ()) -> S,
	-- __methodsMeta: {[string]: Internal.MethodMeta},
	__dontTrack: boolean
}

export type Component<I> = {
	me: I,
	janitor: typeof(Janitor.new()),
	__enabled: boolean;
	type: "Component";
	name: string,
	Destroy: (self: Component<I>) -> (),
	IsEnabled: (self: Component<I>) -> boolean,
	SetEnabled: (self: Component<I>, enabled:boolean) -> (),
	Connect: <T,A...>(self: Component<I>, signal: T&(RBXScriptSignal|Event<A...>), callback: (A...) -> ()) -> T
	-- __methodsMeta: {[string]: Internal.MethodMeta},
}

export type Binding<C> = {
    new: (tag: string, ctor: () -> C & Component<any>) -> Binding<C>,
    Get: (self: Binding<C>, instance: Instance) -> C?,
    GetAll: (self: Binding<C>) -> { [Instance]: C },
    Remove: (self: Binding<C>, instance: Instance) -> (),
    Add: (self: Binding<C>, instance: Instance) -> (),
    _bindings: { [string]: Binding<C> },
    _constructor: () -> C & Component<any>,
    _tag: string,
    _store: { [Instance]: C },
	type: C
}

type Factory2<C> = {
	Bind: (self: Factory2<C>, name:string) -> Binding<C>,
	Connect: <T...>(self: Factory2<C>, event: string|RBXScriptSignal|Event<T...>, method: (self: C, T...) -> ()) -> Factory2<C>;
    New: (self: Factory2<C>, callback: ((self: C) -> ())?) -> Factory2<C>;
}
type Factory1<C> = {
    With: <P,M>(self: Factory1<C>, methods: M&{}, callback: () -> P) -> Factory2<P&C&M>;
}
export type NewFactory = (<I>(t:I&Instance) -> Factory1<Component<I>>)

return {}