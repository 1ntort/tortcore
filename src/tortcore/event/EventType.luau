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

export type EventBus = {
	_: {
		bus: Bus,
		registerSubscription: (EventBus, Event, EventHandler) -> EventSubscription,
	},
	post: (EventBus, Event) -> PostResult,
	shouldPost: (EventBus, Event) -> boolean,
	subscribe: (EventBus, Event, EventHandler) -> EventSubscription,
	subscriptions: (EventBus, Event) -> { EventSubscription },
	unregisterHandler: (EventBus, EventSubscription) -> (),
	close: (EventBus) -> (),
}

export type Bus = {
	_: {
		registry: SubscriberRegistry,
		eventCancelled: (Bus, Event) -> boolean,
		shouldPost: (Bus, Event, EventSubscription) -> boolean,
	},
	post: (Bus, Event) -> PostResult,
	register: (Bus, string, EventSubscription) -> (),
	unregister: (Bus, EventSubscription) -> (),
	unregisterMatching: (Bus, (EventSubscription) -> boolean) -> (),
	unregisterAll: (Bus) -> (),
	hasSubscribers: (Bus, string) -> boolean,
	subscribers: (Bus) -> { [string]: { EventSubscription } },
	handles: (Bus, string) -> { EventSubscription },
}

export type SubscriberRegistry = {
	_: {
		subscribers: { [string]: { EventSubscription } },
	},
	register: (SubscriberRegistry, string, EventSubscription) -> (),
	unregister: (SubscriberRegistry, EventSubscription) -> (),
	unregisterMatching: (SubscriberRegistry, (EventSubscription) -> boolean) -> (),
	unregisterAll: (SubscriberRegistry) -> (),
	subscribers: ((SubscriberRegistry) -> { [string]: { EventSubscription } })
		& ((SubscriberRegistry, string) -> { EventSubscription }),
}

export type EventSubscription = {
	_: {
		eventBus: Bus,
		eventId: string,
		handler: EventHandler,
		active: boolean,
	},
	isActive: (EventSubscription) -> boolean,
	close: (EventSubscription) -> (),
	invoke: (EventSubscription, Event) -> (),
	id: (EventSubscription) -> string,
	handler: (EventSubscription) -> EventHandler,
	consumeCancelledEvents: (EventSubscription) -> boolean,
}

export type PostResult = {
	_: {
		event: Event,
		success: boolean,
		errors: { [EventSubscription]: string },
	},
	event: (PostResult) -> Event,
	successful: (PostResult) -> boolean,
	errors: (PostResult) -> { [EventSubscription]: string },
	throw: (PostResult) -> (),
}

return "EventType"