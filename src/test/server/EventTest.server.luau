--!native
--!nonstrict

local tortcore = require("../../tortcore/")
local PlayerJoinEvent = require("../../tortcore/event/events/PlayerJoinEvent")
local PlayerQuitEvent = require("../../tortcore/event/events/PlayerQuitEvent")

type PlayerJoinEvent = PlayerJoinEvent.PlayerJoinEvent
type PlayerQuitEvent = PlayerQuitEvent.PlayerQuitEvent

local function playerJoin(event: PlayerJoinEvent)
	print(`Somebody joined: {event:player().Name}`)
end

local function playerQuit(event: PlayerQuitEvent)
	print(`Somebody left: {event:player().Name}`)
end

local eventBus = tortcore.get():eventBus()
eventBus:subscribe(PlayerJoinEvent.INSTANCE, playerJoin)
eventBus:subscribe(PlayerQuitEvent.INSTANCE, playerQuit)