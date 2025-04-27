-- Hopefully I can just add these methods to the base Library like in CC


---Splits a string into parts based on the defined separator character(s), returning a table of ordered results.
---@param self string # The string to split.
---@param sep? string # The character(s) to split the string by. (Default: ",")
---@param init? number # The position in the string to start searching from. (Default: 1)
---@param plain? boolean # Whether or not to reconnize patterns in the `sep`. (Default: true)
---@return {[number]:string} # Table of sub-strings.
---
--- @*port* `Luau` `modified` — Added `init` & `plain` param.
function string.split(self, sep, init, plain)
	do -- Parameter type checking & correction
	
		assert(type(self) == 'string', 
		("Bad argument #1; Invalid type! (Expected type(s): 'string'. Got type: '%s'.)"):format(type(self))
		)

		assert(type(sep) == 'string' or type(sep) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): 'string', or 'nil'. Got type: '%s'.)"):format(type(sep))
		)
		sep = sep or ","

		assert(type(init) == 'number' or type(init) == 'nil',
		("Bad argument #3; Invalid type! (Expected type(s): 'number', or 'nil'. Got type: '%s'.)"):format(type(init))
		)
		init = init or 1

		assert(type(plain) == 'boolean' or type(plain) == 'nil',
		("Bad argument #4; Invalid type! (Expected type(s): 'boolean', or 'nil'. Got type: '%s'.)"):format(type(plain))
		)
		if plain == nil then plain = true end

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