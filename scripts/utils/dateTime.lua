

---TODO


local reconsizedPatterns = {
	--"YYYY", "YY";
	--"MM", "M";
	--"DD", "D";
	"HH", "H";
	"hh", "h";
	"AP", "A", "P";
	"mm", "m";
	"ss", "s";
	"SSS", "SS", "S";
}



---@class TimeTable
---@field Year number
---@field Month number
---@field Day number
---@field DayOfWeak number
---@field DayOfYear number
---@field Hour24 number
---@field Hour12 number
---@field Afternoon boolean
---@field Minute number
---@field Second number
---@field Millisecond number


---Converts time in milliseconds into a `TimeTable`.
---@param time number # The Timestamp in milliseconds to convert.
---@return TimeTable # The resulting `TimeTable`.
local function toTimeTable(time)
	do -- Parameter type checking & correction
	
		assert(type(time) == 'number',
		("Bad argument #1; Invalid type! (Expected type(s): 'number'. Got type: '%s'.)"):format(type(time))
		)

	end

	local _return = {}
	_return.Milliseconds = time % 1000
	_return.Seconds = math.floor(time / 1000)
	_return.Minutes = math.floor(_return.Seconds / 60)
	_return.Hours24 = math.floor(_return.Minutes / 60)
	_return.Seconds = _return.Seconds % 60
	_return.Minutes = _return.Minutes % 60
	--_return.Years =
	--_return.Months =
	--_return.Years =

	return _return
end

---Returns a string of the given time formated based on a given pattern.
---@param time number|table # The Timestamp in milliseconds to format, or a `TimeTable`.
---@param pattern string # The pattern to uses to format. If `nil`, uses `"HH:mm:ss.SSS"`.
---@return string # The given timestamp formated.
local function format(time, pattern)
	do -- Parameter type checking & correction
	
		assert(type(time) == 'number' or type(time) == 'table',
		("Bad argument #1; Invalid type! (Expected type(s): 'number', or 'table'. Got type: '%s'.)"):format(type(time))
		)
		if type(time) == 'number' then
			time = toTimeTable(time)
		end

		assert(type(pattern) == 'string' or type(pattern) == 'nil',
		("Bad argument #1; Invalid type! (Expected type(s): 'string', or 'nil'. Got type: '%s'.)"):format(type(pattern))
		)
		pattern = pattern or "HH:mm:ss.SSS"

	end

	local init = 1
	for _,reconsizedPattern in pairs(reconsizedPatterns) do
		local i,j = pattern:find(reconsizedPattern, init, true)

		if i and j then
			
		end
	end

	return ""
end


return {
	toTimeTable = toTimeTable,
	format = format
}