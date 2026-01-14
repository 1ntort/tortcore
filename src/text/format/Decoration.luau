--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../utility/Table")
local TextType = require("../TextType")

--// TYPES \\--

export type Decoration = TextType.Decoration

--// DECLARATIONS \\--

local Decoration = { _ = {} }
local INSTANCE = { _ = {
	decoration = nil,
} }

--// STATIC \\--

function Decoration._.new(decoration: string): Decoration
	local instance = Table.deepcopy(INSTANCE)
	instance._.decoration = decoration
	return instance
end

--// INSTANCE \\--

function INSTANCE.tostring(self: Decoration): string
	return self._.decoration
end

--// END \\--

Decoration.BOLD = Decoration._.new("b")
Decoration.STRIKETHROUGH = Decoration._.new("s")
Decoration.UNDERLINED = Decoration._.new("u")
Decoration.ITALIC = Decoration._.new("i")

return Decoration