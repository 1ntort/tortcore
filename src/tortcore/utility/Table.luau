--!native
--!nonstrict

--// IMPORTS \\--

--// DECLARATIONS \\--

local Table = { _ = {} }

--// STATIC \\--

function Table.deepcopy<T>(t: T): T
	if typeof(t) ~= "table" then return t end

	local new = {}
	for index, value in t do
		new[index] = Table.deepcopy(value)
	end
	return new
end

function Table.reverse(t: { [number]: any }): { [number]: any }
	for i = 1, math.floor(#t / 2) do
		local j = #t - i + 1
		t[i], t[j] = t[j], t[i]
	end
	return t
end

--// END \\--

return Table
