--!native
--!nonstrict

--// TESTS \\--

local text = game:GetService("Workspace").tortcore.tortcore.text
local Component = require(text.Component)
local Decoration = require(text.format.Decoration)
local Font = require(text.format.Font)
local Mark = require(text.format.Mark)
local Stroke = require(text.format.Stroke)

local textChatService = game:GetService("TextChatService")
local channel: TextChannel =
	textChatService:WaitForChild("TextChannels"):WaitForChild("RBXGeneral")

-- Test 1: Decorations
do
	local component = Component.fromChildren(
		Component.new("TEST NUMBER ONE")
			:decorate(Decoration.BOLD, Decoration.UNDERLINED),
		Component.newline(),
		Component.new("TEST NUMBER TWO")
			:decorate(Decoration.ITALIC, Decoration.STRIKETHROUGH)
	)

	print(component:tostring())
	channel:DisplaySystemMessage(component:tostring())
end

-- Test 2: Font
do
	local component = Component.fromChildren(
		Component.new("TEST NUMBER THREE")
			:font(Font.new()
				:color(Color3.fromHex("#FF7800"))
				:transparency(0.3)
				:size(40)
			),
		Component.newline(),
		Component.new("TEST NUMBER FOUR")
			:font(Font.new()
				:face("Michroma")
				:weight("light")
			)
	)

	print(component:tostring())
	channel:DisplaySystemMessage(component:tostring())
end

-- Test 3: Mark
do
	local component = Component.fromChildren(
		Component.new("TEST NUMBER FIVE")
			:mark(Mark.new()
				:color(Color3.fromHex("#00FF00"))
				:transparency(0)
			),
		Component.newline(),
		Component.new("TEST NUMBER SIX")
			:mark(Mark.new()
				:color(Color3.fromHex("#0000FF"))
				:transparency(0.7)
			)
	)

	print(component:tostring())
	channel:DisplaySystemMessage(component:tostring())
end

-- Test 4: Stroke
do
	local component = Component.new("TEST NUMBER SEVEN")
		:stroke(Stroke.new()
			:color(Color3.fromHex("#00FF00"))
			:transparency(0)
			:thickness(2)
			:joins("round")
			:sizing("fixed")
		)

	print(component:tostring())
	channel:DisplaySystemMessage(component:tostring())
end

-- Test 5: Everything
do
	local component = Component.new("TEST NUMBER EIGHT")
		:decorate(Decoration.BOLD, Decoration.UNDERLINED, Decoration.UNDERLINED, Decoration.STRIKETHROUGH)
		:font(Font.new()
			:color(Color3.fromHex("#FF0000"))
			:transparency(0.3)
			:size(40)
			:face("Michroma")
			:weight("light")
		)
		:mark(Mark.new()
			:color(Color3.fromHex("#0000FF"))
			:transparency(0)
		)
		:stroke(Stroke.new()
			:color(Color3.fromHex("#00FF00"))
			:transparency(0)
			:thickness(2)
			:joins("round")
			:sizing("fixed")
		)

	print(component:tostring())
	channel:DisplaySystemMessage(component:tostring())
end