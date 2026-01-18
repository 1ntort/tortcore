--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../../utility/Table")
local EventType = require("../EventType")

type Event = EventType.Event
type EventSubscription = EventType.EventSubscription

--// TYPES \\--

export type PostResult = EventType.PostResult

--// DECLARATIONS \\--

local PostResult = { _ = {} }
local INSTANCE = { _ = {
	event = nil,
	success = nil,
	errors = {}
} }

--// STATIC \\--

function PostResult.new<T>(event: T & Event, success: boolean, errors: { [EventSubscription]: string }?): PostResult
	local instance = Table.deepcopy(INSTANCE)
	instance._.event = event
	instance._.success = success
	if not success then
		instance._.errors = errors
	end
	return instance
end

function PostResult.success<T>(event: T & Event)
	return PostResult.new(event, true)
end

function PostResult.failure<T>(event: T & Event, errors: { [EventSubscription]: string }): PostResult
	return PostResult.new(event, false, errors)
end

--// INSTANCE \\--

function INSTANCE.event<T>(self: PostResult): T & Event
	return self._.event
end

function INSTANCE.successful(self: PostResult): boolean
	return self._.success
end

function INSTANCE.errors(self: PostResult): { [EventSubscription]: string }
	return self._.errors
end

function INSTANCE.throw(self: PostResult)
	if self.successful(self) then return end
	
	local errors = ""
	local current = 0
	for index, message in self.errors(self) do
		current += 1
		errors = errors .. `\n[{current}]: {message}`
	end
	warn(`Errors occured while posting an event to its subscribers: {errors}`)
end

--// END \\--

return PostResult