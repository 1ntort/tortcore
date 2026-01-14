--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../utility/Table")
local EventType = require("./EventType")
local Bus = require("@self/Bus")
local EventSubscription = require("@self/EventSubscription")

type Event = EventType.Event
type EventHandler = EventType.EventHandler
type EventSubscription = EventType.EventSubscription
type PostResult = EventType.PostResult

--// TYPES \\--

export type EventBus = EventType.EventBus

--// DECLARATIONS \\--

local EventBus = { _ = {} }
local INSTANCE = { _ = {} }

--// STATIC \\--

function EventBus.new(): EventBus
	local instance = Table.deepcopy(INSTANCE)
	instance._.bus = Bus.new()
	return instance
end

--// INSTANCE \\--

function INSTANCE.post(self: EventBus, event: Event): PostResult
	return self._.bus:post(event)
end

function INSTANCE.shouldPost(self: EventBus, event: Event): boolean
	return self._.bus:hasSubscribers(event.id())
end

function INSTANCE.subscribe(self: EventBus, event: Event, handler: EventHandler): EventSubscription
	return self._.registerSubscription(self, event, handler)
end

function INSTANCE._.registerSubscription(self: EventBus, event: Event, handler: EventHandler): EventSubscription
	local subscription = EventSubscription.new(self, event:id(), handler)
	self._.bus:register(event:id(), subscription)
	
	return subscription
end

function INSTANCE.subscriptions(self: EventBus, event: Event): { EventSubscription }
	return self._.bus:handles(event.id())
end

function INSTANCE.unregisterHandler(self: EventBus, handler: EventSubscription)
	self._.bus:unregister(handler)
end

function INSTANCE.close(self: EventBus)
	self._.bus:unregisterAll()
end

--// END \\--

return EventBus
