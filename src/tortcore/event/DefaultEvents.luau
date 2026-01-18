--!native
--!nonstrict

--// IMPORTS \\--

local EventType = require("./EventType")

type EventBus = EventType.EventBus
type Event = EventType.Event

--// TYPES \\--

type RawEvent = {
	new: (...any) -> Event,
    INSTANCE: Event,
	id: string,
	default: boolean | nil | {
		type: string,
		value: any,
	},
}

--// DECLARATIONS \\--

local DefaultEvents = { _ = {} }

--// STATIC \\--

function DefaultEvents.register(eventBus: EventBus)
	local events: Folder = script.Parent:FindFirstChild("events")
	if events then
		for _, module in events:GetDescendants() do
			if module:IsA("ModuleScript") then
				local event: RawEvent = require(module)
				if event and event.default then
                    local success, result = pcall(DefaultEvents._.handle, eventBus, event)
					if not success then
                        warn(`Failed to add default event '{tostring(module.Name)}': {tostring(result)}`)
					end
				end
			end
		end
	end
end

function DefaultEvents._.handle(eventBus: EventBus, event: RawEvent)
	local defaultType: string = event.default.type
    if defaultType == "RBXScriptSignal" then
        DefaultEvents._.handleSignal(eventBus, event, event.default.value)
    end
end

function DefaultEvents._.handleSignal(eventBus: EventBus, event: RawEvent, signal: RBXScriptSignal)
	signal:Connect(function(...: any)
		if eventBus:shouldPost(event.INSTANCE) then
			eventBus:post(event.new(...))
		end
	end)
end

--// END \\--

return DefaultEvents
