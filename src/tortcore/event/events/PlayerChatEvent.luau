--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../../utility/Table")
local EventType = require("../EventType")

type Event = EventType.Event

--// TYPES \\--

export type PlayerChatEvent = {
	_: {
		cancelled: boolean,
		player: Player
	},
	cancelled: ((PlayerChatEvent) -> boolean)
		& ((PlayerChatEvent, boolean) -> ()),
	player: (PlayerChatEvent) -> Player
} & Event

--// DECLARATIONS \\--

local PlayerChatEvent = {
	_ = {},
	id = game:GetService("HttpService"):GenerateGUID(false),
	default = false,
}
local INSTANCE = { _ = {
	cancelled = false,
	player = nil,
},
	attributes = { ["cancellable"] = true }
}

--// STATIC \\--

function PlayerChatEvent.new(player: Player): PlayerChatEvent
	local instance = Table.deepcopy(INSTANCE)
	instance._.player = player
	return instance
end

--// INSTANCE \\--

function INSTANCE.cancelled(self: PlayerChatEvent, cancelled: boolean?): boolean?
	if cancelled == nil then
		return self._.cancelled
	end
	self._.cancelled = cancelled
	return
end

function INSTANCE.player(self: PlayerChatEvent): Player
	return self._.player
end

function INSTANCE.id(self: PlayerChatEvent): string
	return PlayerChatEvent.id
end

--// END \\--

PlayerChatEvent.INSTANCE = PlayerChatEvent.new()

return PlayerChatEvent