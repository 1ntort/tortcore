--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("@self/utility/Table")
local EventType = require("@self/event/EventType")
local EventBus = require("@self/event/EventBus")
local DefaultEvents = require("@self/event/DefaultEvents")

type EventBus = EventType.EventBus

--// TYPES \\--

export type Core = {
	_: {
		eventBus: EventBus
	},
	eventBus: (Core) -> EventBus
}

--// DECLARATIONS \\--

local Core = { _ = {
	instance = nil,
} }
local INSTANCE = { _ = {
	eventBus = nil,
} }

--// STATIC \\--

function Core._.new(): Core
	local instance = Table.deepcopy(INSTANCE)
	instance._.eventBus = EventBus.new()
	DefaultEvents.register(instance:eventBus())

	if Core._.instance == nil then
		Core._.instance = instance
	end
	return instance
end

function Core.get(): Core
	return Core._.instance
end

--// INSTANCE \\--

function INSTANCE.eventBus(self: Core)
	return self._.eventBus
end

--// END \\--

if Core._.instance == nil then
	Core._.instance = Core._.new()
end

return Core