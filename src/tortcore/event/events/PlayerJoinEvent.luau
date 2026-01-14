--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../../utility/Table")
local EventType = require("../EventType")

type Event = EventType.Event

--// TYPES \\--

export type PlayerJoinEvent = {
	_: {
		cancelled: boolean,
		player: Player
	},
	cancelled: ((PlayerJoinEvent) -> boolean)
		& ((PlayerJoinEvent, boolean) -> ()),
	player: (PlayerJoinEvent) -> Player
} & Event

--// DECLARATIONS \\--

local PlayerJoinEvent = { _ = {} }
local INSTANCE = { _ = {
	cancelled = false,
	player = nil,
},
	attributes = { ["cancellable"] = true }
}

--// STATIC \\--

function PlayerJoinEvent.new(player: Player): PlayerJoinEvent
	local instance = Table.deepcopy(INSTANCE)
	instance._.player = player
	return instance
end

--// INSTANCE \\--

function INSTANCE.cancelled(self: PlayerJoinEvent, cancelled: boolean?): boolean?
	if cancelled == nil then
		return self._.cancelled
	end
	self._.cancelled = cancelled
	return
end

function INSTANCE.player(self: PlayerJoinEvent): Player
	return self._.player
end

function INSTANCE.id(self: PlayerJoinEvent): string
	return "PlayerJoinEvent"
end

--// END \\--

PlayerJoinEvent.INSTANCE = PlayerJoinEvent.new()

return PlayerJoinEvent