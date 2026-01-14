--!strict

--// EVENT \\--

export type Event = {
	attributes: { [string]: true },
	id: () -> string,
}
export type EventHandler = (Event) -> ()
export type EventInstance = {
	new: () -> Event,
	getModule: () -> ModuleScript,
}

--// MODULES \\--

export type EventSubscription = {
	_: {
		eventBus: any,
		eventId: string,
		handler: EventHandler,
		active: boolean,
	},
	isActive: (EventSubscription) -> boolean,
	close: (EventSubscription) -> (),
	invoke: (EventSubscription, Event) -> (),
	id: (EventSubscription) -> string,
	handler: (EventSubscription) -> EventHandler,
}

return "EventType"