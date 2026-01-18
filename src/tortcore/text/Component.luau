--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../utility/Table")
local TextType = require("./TextType")

type Decoration = TextType.Decoration
type Font = TextType.Font
type Stroke = TextType.Stroke
type Mark = TextType.Mark

--// TYPES \\--

export type Component = TextType.Component

--// DECLARATIONS \\--

local Component = { _ = {} }
local INSTANCE = { _ = {
	text = nil,
	case = nil,
	decorations = {},
	font = nil,
	mark = nil,
	stroke = nil,
	children = {},
} }

--// STATIC \\--

function Component.new(text: string): Component
	local instance = Table.deepcopy(INSTANCE)
	instance._.text = text
	return instance
end

function Component.empty(): Component
	return Component._.EMPTY
end

function Component.space(): Component
	return Component._.SPACE
end

function Component.newline(): Component
	return Component._.NEWLINE
end

function Component.fromChildren(...: Component): Component
	local converted = Component.empty()
	for _, component in { ... } do
		converted:append(component)
	end
	return converted
end

--// INSTANCE \\--

function INSTANCE.uppercase(self: Component): Component
	self._.case = "uc"
	return self
end

function INSTANCE.smallcaps(self: Component): Component
	self._.case = "sc"
	return self
end

function INSTANCE.decorate(self: Component, ...: Decoration): Component
	for _, decoration in { ... } do
		if self._.decorations[decoration:tostring()] == nil then
			self._.decorations[decoration:tostring()] = decoration
		end
	end
	return self
end

function INSTANCE.font(self: Component, font: Font): Component
	self._.font = font
	return self
end

function INSTANCE.mark(self: Component, mark: Mark): Component
	self._.mark = mark
	return self
end

function INSTANCE.stroke(self: Component, stroke: Stroke): Component
	self._.stroke = stroke
	return self
end

function INSTANCE.append(self: Component, child: Component): Component
	table.insert(self._.children, child)
	return self
end

function INSTANCE.appendSpace(self: Component): Component
	table.insert(self._.children, Component.space())
	return self
end

function INSTANCE.appendNewline(self: Component): Component
	table.insert(self._.children, Component.newline())
	return self
end

function INSTANCE.tostring(self: Component): string
	local prefix = ""
	local suffix = ""
	
	for _, decoration in self._.decorations do
		prefix = prefix .. `<{decoration:tostring()}>`
		suffix = `</{decoration:tostring()}>` .. suffix
	end
	if self._.case ~= nil then
		prefix = prefix .. `<{self._.case}>`
		suffix = `</{self._.case}>` .. suffix
	end
	if self._.font ~= nil then
		prefix = prefix .. self._.font:tostring()
		suffix = "</font>" .. suffix
	end
	if self._.mark ~= nil then
		prefix = prefix .. self._.mark:tostring()
		suffix = "</mark>" .. suffix
	end
	if self._.stroke ~= nil then
		prefix = prefix .. self._.stroke:tostring()
		suffix = "</stroke>" .. suffix
	end
	
	local converted = prefix .. self._.text .. suffix
	for _, child in self._.children do
		converted = converted .. child:tostring()
	end
	return converted
end

--// END \\--

Component._.EMPTY = Component.new("")
Component._.SPACE = Component.new(" ")
Component._.NEWLINE = Component.new("<br/>")

return Component