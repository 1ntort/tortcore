--!native
--!nonstrict

local tortcore = require("../../tortcore/")
local PlayerJoinEvent = require("../../tortcore/event/events/PlayerJoinEvent")

type PlayerJoinEvent = PlayerJoinEvent.PlayerJoinEvent

local function playerJoin(event: PlayerJoinEvent)
	print(`Somebody joined: {event:player().Name}`)
end

local eventBus = tortcore.get():eventBus()
eventBus:subscribe(PlayerJoinEvent.INSTANCE, playerJoin)