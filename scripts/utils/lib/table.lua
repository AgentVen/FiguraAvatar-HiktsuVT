-- Hopefully I can just add these methods to the base Library like in CC


---Returns the index of the first occurrence of needle within the haystack starting from init.
---@param haystack {[number]:any} # Table to search.
---@param needle any # Value that you're trying to find.
---@param init number? # The index to start searching from. (Default: 1)
---@param len number? # The length of the table to search through. (Default: -1)
---@param plain boolean? # If the needle is a string, whether or not to treat it as a pattern. (Default: true)
---@return number|nil # Returns the index position in the table if found, or nil if not.
---
--- @*port* `Luau` `modified` — Added `len` & `plain` param.
function table.find(haystack, needle, init, len, plain)
	do-- Parameter type checking & correction
		assert(type(haystack) == 'table', 
		"bad argument #1 (table expected, got "..type(haystack)..".)"
		)
		assert(type(init) == 'number' or type(init) == 'nil', 
		"bad argument #3 (number, or nil expected, got "..type(init)..".)"
		); init = init or 1; if init < 0 then init = #haystack + 1 + init end
		assert(type(len) == 'number' or type(len) == 'nil', 
		"bad argument #4 (number, or nil expected, got "..type(len)..".)"
		); len = len or -1; if len < 0 then len = #haystack + 1 + len end
		assert(type(plain) == 'boolean' or type(plain) == 'nil', 
		"bad argument #5 (boolean, or nil expected, got "..type(plain)..".)"
		); if plain == nil then plain = true end
	end

	for i = init, len, 1 do
		if haystack[i] then
			if plain == false and type(needle) == 'string' then
				if string.find(haystack[i], needle) then
					return i
				end
			else
				if haystack[i] == needle then
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
	do-- Parameter type checking & correction
		assert(type(t) == 'table',
		"bad argument #1 (table expected, got "..type(t)..".)"
		)
		assert(type(depth) == 'number' or type(depth) == 'nil',
		"bad argument #2 (number, or nil expected, got "..type(depth)..".)"
		); depth = depth or 0
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