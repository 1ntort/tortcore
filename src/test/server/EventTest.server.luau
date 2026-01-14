--!native
--!nonstrict

local PlayerJoinEvent = require("../../tortcore/event/events/PlayerJoinEvent")
local EventBus = require("../../tortcore/event/EventBus")

type PlayerJoinEvent = PlayerJoinEvent.PlayerJoinEvent

local function playerJoin(event: PlayerJoinEvent)
	print(`Somebody joined: {event:player().Name}`)
end

local eventBus = EventBus.new()
eventBus:subscribe(PlayerJoinEvent.INSTANCE, playerJoin)

game:GetService("Players").PlayerAdded:Connect(function(player: Player)
	local result = eventBus:post(PlayerJoinEvent.new(player))
	if result:successful() then
		print("The test event ran successfully!")
		print(result:event())
	else
		result:throw()
	end
end)