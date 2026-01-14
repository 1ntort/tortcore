--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../utility/Table")
local TextType = require("../TextType")

--// TYPES \\--

export type Font = TextType.Font

--// DECLARATIONS \\--

local Font = { _ = {} }
local INSTANCE = { _ = {
	color = nil,
	size = nil,
	face = nil,
	family = nil,
	weight = nil,
	transparency = nil,
} }

--// STATIC \\--

function Font.new(color: Color3?, size: number?, transparency: number?, weight: number?, face: string?, family: string?): Font
	local instance = Table.deepcopy(INSTANCE)
	instance._.color = if color then "#" .. color:ToHex() else nil
	instance._.size = size
	instance._.transparency = transparency
	instance._.weight = weight
	instance._.face = face
	instance._.family = family
	return instance
end

--// INSTANCE \\--

function INSTANCE.color(self: Font, color: Color3): Font
	self._.color = "#" .. color:ToHex()
	return self
end

function INSTANCE.size(self: Font, size: number): Font
	self._.size = size
	return self
end

function INSTANCE.face(self: Font, face: string): Font
	self._.face = face
	return self
end

function INSTANCE.family(self: Font, family: string): Font
	self._.family = family
	return self
end

function INSTANCE.weight(self: Font, weight: string): Font
	self._.weight = weight
	return self
end

function INSTANCE.transparency(self: Font, transparency: number): Font
	self._.transparency = transparency
	return self
end

function INSTANCE.tostring(self: Font): string
	local converted = "<font"
	for name, value in self._ do
		if value == nil then continue end
		converted = converted .. ` {tostring(name)}="{tostring(value)}"`
	end
	return converted .. ">"
end

--// END \\--

return Font