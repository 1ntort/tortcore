--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../utility/Table")
local TextType = require("../TextType")

type Joins = TextType.Joins
type Sizing = TextType.Sizing

--// TYPES \\--

export type Stroke = TextType.Stroke

--// DECLARATIONS \\--

local Stroke = { _ = {} }
local INSTANCE = { _ = {
	color = nil,
	thickness = nil,
	transparency = nil,
	joins = nil,
	sizing = nil,
} }

--// STATIC \\--

function Stroke.new(color: Color3?, thickness: number?, transparency: number?, joins: Joins?, sizing: Sizing?): Stroke
	local instance = Table.deepcopy(INSTANCE)
	instance._.color = if color then "#" .. color:ToHex() else nil
	instance._.thickness = thickness
	instance._.transparency = transparency
	instance._.joins = joins
	instance._.sizing = sizing
	return instance
end

--// INSTANCE \\--

function INSTANCE.color(self: Stroke, color: Color3): Stroke
	self._.color = "#" .. color:ToHex()
	return self
end

function INSTANCE.thickness(self: Stroke, thickness: number): Stroke
	self._.thickness = thickness
	return self
end

function INSTANCE.transparency(self: Stroke, transparency: number): Stroke
	self._.transparency = transparency
	return self
end

function INSTANCE.joins(self: Stroke, joins: Joins): Stroke
	self._.joins = joins
	return self
end

function INSTANCE.sizing(self: Stroke, sizing: Sizing): Stroke
	self._.sizing = sizing
	return self
end

function INSTANCE.tostring(self: Stroke): string
	local converted = "<stroke"
	for name, value in self._ do
		if value == nil then continue end
		converted = converted .. ` {tostring(name)}="{tostring(value)}"`
	end
	return converted .. ">"
end

--// END \\--

return Stroke