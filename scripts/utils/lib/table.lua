-- Hopefully I can just add these methods to the base Library like in CC


---Returns the index of the first occurrence of needle within the haystack starting from init.
---@param haystack {[number]:any} # Table to search.
---@param needle any # Value that you're trying to find.
---@param init number? # The index to start searching from. (Default: 1)
---@param len number? # The length of the table to search through. (Default: -1)
---@param mode number? # The mode which should be used when using the needle. (Default: 0)
---| '0: plain' # Needle isn't used in any special way.
---| '1: string pattern' # If the needle is a string, it will be used as a string pattern.
---| '2: condition function' # If the needle is a function, it will call the function with the parameters `i` (index) & `v` (value), and will return on the first occurrence of the given function returning a positive value.
---@return number|nil # Returns the index position in the table if found, or nil if not.
---
--- @*port* `Luau` `modified` — Added `len` & `plain` param.
function table.find(haystack, needle, init, len, mode)
	do -- Parameter type checking & correction
		
		assert(type(haystack) == 'table', 
		"(table.find #1) Invalid type!\n\tExpected type: 'table'. Got: '"..type(haystack).."'."
		)

		assert(type(init) == 'number' or type(init) == 'nil', 
		"(table.find #2) Invalid type!\n\tExpected type: 'number', or 'nil'. Got: '"..type(init).."'."
		)
		init = init or 1
		if init < 0 then init = #haystack + 1 + init end

		assert(type(len) == 'number' or type(len) == 'nil', 
		"(table.find #3) Invalid type!\n\tExpected type: 'number', or 'nil'. Got: '"..type(len).."'."
		)
		len = len or -1
		if len < 0 then len = #haystack + 1 + len end

		assert(type(mode) == 'number' or type(mode) == 'nil', 
		"(table.find #4) Invalid type!\n\tExpected type: 'number', or 'nil'. Got: '"..type(mode).."'."
		)
		mode = mode or 0
		assert(mode >= 0 and mode <= 2,
		"(table.find #4) Out of range!\n\tExpected a number: from 0, to 2. Got: "..type(mode).."."
		)

	end

	for i = init, len, 1 do
		if haystack[i] then
			-- Normal
			if (mode == 0) then
				if string.find(haystack[i], needle) then
					return i
				end
			-- String pattern
			elseif (mode == 1) and type(needle) == 'string' then
				if haystack[i] == needle then
					return i
				end
			-- Condition function
			elseif (mode == 2) and (type(needle) == 'function' or type (needle) == 'thread') then
				if needle(i, haystack[i]) then
					return i
				end
			end
		end
	end

	return nil
end

---Returns an shallow, unless a depth is provided, copy of the provided table.
---@param t table # The table to be cloned.
---@param depth number? # How deep should the cloning go, can be set to -1 to be infinite. (Default: 0)
---@return table # A clone of the provided table.
---
--- @*port* `Luau` `modified` — Added `depth` param.
function table.clone(t, depth)
	do -- Parameter type checking & correction
	
		assert(type(t) == 'table',
		"(table.clone #1) Invalid type!\n\tExpected type: 'table'. Got: '"..type(t).."'."
		)

		assert(type(depth) == 'number' or type(depth) == 'nil',
		"(table.clone #2) Invalid type!\n\tExpected type: 'number', or 'nil'. Got: '"..type(depth).."'."
		)
		depth = depth or 0

	end

	local _return = {}

	for e,v in pairs(t) do
		if type(v) == 'table' then
			if depth ~= 0 then
				_return[e] = table.clone(v, depth - 1)
			else
				_return[e] = {}
			end
		else
			_return[e] = v
		end
	end

	return _return
end