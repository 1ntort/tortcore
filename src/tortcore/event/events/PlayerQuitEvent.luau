--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../../utility/Table")
local EventType = require("../EventType")

type Event = EventType.Event
type PostResult = EventType.PostResult

--// TYPES \\--

export type PlayerQuitEvent = {
	_: {
		cancelled: boolean,
		player: Player
	},
	player: (PlayerQuitEvent) -> Player
} & Event

--// DECLARATIONS \\--

local PlayerQuitEvent = {
	_ = {},
	id = game:GetService("HttpService"):GenerateGUID(false),
	default = {
		type = "RBXScriptSignal",
		value = game:GetService("Players").PlayerRemoving
	}
}
local INSTANCE = { _ = {
	cancelled = false,
	player = nil,
},
	attributes = { ["cancellable"] = true }
}

--// STATIC \\--

function PlayerQuitEvent.new(player: Player): PlayerQuitEvent
	local instance = Table.deepcopy(INSTANCE)
	instance._.player = player
	return instance
end

--// INSTANCE \\--

function INSTANCE.player(self: PlayerQuitEvent): Player
	return self._.player
end

function INSTANCE.id(self: PlayerQuitEvent): string
	return PlayerQuitEvent.id
end

--// END \\--

PlayerQuitEvent.INSTANCE = PlayerQuitEvent.new()

return PlayerQuitEvent