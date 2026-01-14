--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../../utility/Table")
local EventType = require("../EventType")

type EventSubscription = EventType.EventSubscription

--// TYPES \\--

export type SubscriberRegistery = {
	_: {
		subscribers: { [string]: { EventSubscription } },
	},
	register: (SubscriberRegistery, string, EventSubscription) -> (),
	unregister: (SubscriberRegistery, EventSubscription) -> (),
	unregisterMatching: (SubscriberRegistery, (EventSubscription) -> boolean) -> (),
	unregisterAll: (SubscriberRegistery) -> (),
	subscribers: ((SubscriberRegistery) -> { [string]: { EventSubscription } })
		& ((SubscriberRegistery, string) -> { EventSubscription }),
}

--// DECLARATIONS \\--

local SubscriberRegistry = { _ = {} }
local INSTANCE = { _ = {
	subscribers = {}
} }

--// STATIC \\--

function SubscriberRegistry.new(): SubscriberRegistery
	local instance = Table.deepcopy(INSTANCE)
	return instance
end

--// INSTANCE \\--

function INSTANCE.register(self: SubscriberRegistery, id: string, subscriber: EventSubscription)
	if self._.subscribers[id] == nil then
		self._.subscribers[id] = {}
	end
	table.insert(self._.subscribers[id], subscriber)
end

function INSTANCE.unregister(self: SubscriberRegistery, subscriber: EventSubscription)
	self.unregisterMatching(self, function(h) return h == subscriber end)
end

function INSTANCE.unregisterMatching(self: SubscriberRegistery, predictate: (EventSubscription) -> boolean)
	for _, subscribers: { EventSubscription } in self._.subscribers do
		for index, subscriber in subscribers do
			if predictate(subscriber) then
				subscribers[index] = nil
			end
		end
	end
end

function INSTANCE.unregisterAll(self: SubscriberRegistery)
	self._.subscribers = {}
end

function INSTANCE.subscribers(self: SubscriberRegistery, id: string?)
	if id == nil then
		return table.clone(self._.subscribers)
	elseif self._.subscribers[id] == nil then
		return {}
	end
	return table.clone(self._.subscribers[id])
end

--// END \\--

return SubscriberRegistry
