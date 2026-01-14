--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../../utility/Table")
local EventType = require("../EventType")
local SubscriberRegistry = require("./SubscriberRegistry")
local PostResult = require("./PostResult")

type Event = EventType.Event
type EventSubscription = EventType.EventSubscription
type SubscriberRegistry = EventType.SubscriberRegistry
type PostResult = PostResult.PostResult

--// TYPES \\--

export type Bus = EventType.Bus

--// DECLARATIONS \\--

local Bus = { _ = {} }
local INSTANCE = { _ = {
	registry = nil,
} }

--// STATIC \\--

function Bus.new(): Bus
	local instance = Table.deepcopy(INSTANCE)
	instance._.registry = SubscriberRegistry.new()
	return instance
end

--// INSTANCE \\--

function INSTANCE._.eventCancelled(self: Bus, event: Event): boolean
	if event.attributes["cancellable"] == nil then return false end
	if typeof(event.cancelled) ~= "function" then
		error(`Event '{event:id()}' was found with the 'cancellable', but no 'cancelled' function.`)
	end
	return event:cancelled() :: boolean
end

function INSTANCE._.shouldPost(self: Bus, event: Event, subscriber: EventSubscription): boolean
	if (not subscriber:consumeCancelledEvents()) and self._.eventCancelled(self, event) then return false end
	return true
end

function INSTANCE.post(self: Bus, event: Event): PostResult
	local errors: { [EventSubscription]: string } = {}
	for _, subscriber in self._.registry:subscribers(event:id()) do
		if not self._.shouldPost(self, event, subscriber) then continue end
		
		local success, result = pcall(subscriber.invoke, subscriber, event)
		if success == false then
			errors[subscriber] = tostring(result)
		end
	end
	if #errors == 0 then
		return PostResult.success(event)
	else
		return PostResult.failure(event, errors)
	end
end

function INSTANCE.register(self: Bus, id: string, subscriber: EventSubscription)
	self._.registry:register(id, subscriber)
end

function INSTANCE.unregister(self: Bus, subscriber: EventSubscription)
	self._.registry:unregister(subscriber)
end

function INSTANCE.unregisterMatching(self: Bus, predictate: (EventSubscription) -> boolean)
	self._.registry:unregisterMatching(predictate)
end

function INSTANCE.unregisterAll(self: Bus)
	self._.registry:unregisterAll()
end

function INSTANCE.hasSubscribers(self: Bus, id: string): boolean
	return #self._.registry:subscribers(id) ~= 0
end

function INSTANCE.subscribers(self: Bus): { [string]: { EventSubscription } }
	return self._.registry:subscribers()
end

function INSTANCE.handles(self: Bus, id: string): { EventSubscription }
	local handles: { EventSubscription } = {}
	for _, handle: EventSubscription in self.subscribers(self) do
		if handle:id() == id then
			table.insert(handles, handle)
		end
	end
	return handles
end

--// END \\--

return Bus
