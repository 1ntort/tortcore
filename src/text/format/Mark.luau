--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../utility/Table")
local TextType = require("../TextType")

--// TYPES \\--

export type Mark = TextType.Mark

--// DECLARATIONS \\--

local Mark = { _ = {} }
local INSTANCE = { _ = {
	color = nil,
	transparency = nil,
} }

--// STATIC \\--

function Mark.new(color: Color3?, transparency: number?): Mark
	local instance = Table.deepcopy(INSTANCE)
	instance._.color = if color then "#" .. color:ToHex() else nil
	instance._.transparency = transparency
	return instance
end

--// INSTANCE \\--

function INSTANCE.color(self: Mark, color: Color3): Mark
	self._.color = "#" .. color:ToHex()
	return self
end

function INSTANCE.transparency(self: Mark, transparency: number): Mark
	self._.transparency = transparency
	return self
end

function INSTANCE.tostring(self: Mark): string
	local converted = "<mark"
	for name, value in self._ do
		if value == nil then continue end
		converted = converted .. ` {tostring(name)}="{tostring(value)}"`
	end
	return converted .. ">"
end

--// END \\--

return Mark