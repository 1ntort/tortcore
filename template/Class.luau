--!native
--!nonstrict

--// IMPORTS \\--

local Table = require("../utility/Table")

--// TYPES \\--

export type INSERT_CLASS_HERE = {
	_: {
		
	}
}

--// DECLARATIONS \\--

local INSERT_CLASS_HERE = { _ = {} }
local INSTANCE = { _ = {} }

--// STATIC \\--

function INSERT_CLASS_HERE.new(): INSERT_CLASS_HERE
	local instance = Table.deepcopy(INSTANCE)
	return instance
end

--// INSTANCE \\--

function INSTANCE.EXAMPLE_FUNCTION(self: INSERT_CLASS_HERE)
	
end

--// END \\--

return INSERT_CLASS_HERE