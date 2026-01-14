--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../../utility/Table")
local EventType = require("../EventType")

type EventHandler = EventType.EventHandler
type Event = EventType.Event

--// TYPES \\--

export type EventSubscription = EventType.EventSubscription

--// DECLARATIONS \\--

local EventSubscription = { _ = {} }
local INSTANCE = { _ = {
	eventBus = nil,
	id = nil,
	handler = nil,
	active = true,
} }

--// STATIC \\--

function EventSubscription.new(eventBus: any, id: string, handler: EventHandler): EventSubscription
	local instance = Table.deepcopy(INSTANCE)
	instance._.eventBus = eventBus
	instance._.id = id
	instance._.handler = handler
	return instance
end

--// INSTANCE \\--

function INSTANCE.isActive(self: EventSubscription): boolean
	return self._.active
end

function INSTANCE.close(self: EventSubscription)
	if self._.active == false then return end
	self._.active = false
	
	self._.eventBus:unregisterHandler(self)
end

function INSTANCE.invoke(self: EventSubscription, event: Event)
	local success, result = pcall(self._.handler, event)
	if success == false then
		local name = debug.info(self._.handler, "n")
		warn(`Unable to pass event '{event.id()}'' to handler '{name or "unknown"}': {tostring(result)}`)
	end
end

function INSTANCE.id(self: EventSubscription): string
	return self._.id
end

function INSTANCE.handler(self: EventSubscription): EventHandler
	return self._.handler
end

function INSTANCE.consumeCancelledEvents(self: EventSubscription): boolean
	return true
end

--// END \\--

return EventSubscription