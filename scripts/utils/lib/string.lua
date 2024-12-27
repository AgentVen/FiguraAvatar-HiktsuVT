-- Hopefully I can just add these methods to the base Library like in CC


---Splits a string into parts based on the defined separator character(s), returning a table of ordered results.
---@param self string # The string to split.
---@param sep? string # The character(s) to split the string by. (Default: ",")
---@param init? number|integer # The position in the string to start searching from. (Default: 1)
---@param plain? boolean # Whether or not to reconnize patterns in the `sep`. (Default: true)
---@return {[number|integer]:string} # Table of sub-strings.
---
--- @*port* `Luau` `modified` — Added `init` & `plain` param.
function string.split(self, sep, init, plain)
	do-- Parameter type checking & correction
		assert(type(self) == 'string', 
		"bad argument #1 (string expected, got "..type(self)..".)"
		)
		assert(type(sep) == 'string' or type(sep) == 'nil',
		"bad argument #2 (string, or nil expected, got "..type(sep)..".)"
		); sep = sep or ","
		assert(type(init) == 'number' or type(init) == 'nil',
		"bad argument #3 (number, or nil expected, got "..type(init)..".)"
		); init = init or 1
		assert(type(plain) == 'boolean' or type(plain) == 'nil',
		"bad argument #4 (boolean, or nil expected, got "..type(plain)..".)"
		); if plain == nil then plain = true end
	end

	local _return = {}

	while true do
		local i,j = string.find(self, sep, init, plain)

		table.insert(_return, string.sub(self, init, (((i == nil) and -1) or i - 1)))

		if not j then break end
		init = j + 1
	end

	return _return
end