---@class Enum
_G.Enum = {}

---@param name string
---@return table
function _G.Enum:createDir(name)
	local path = self

	local split = name:split(".")
	for _,v in pairs(split) do
		if not path[v] then
			path[v] = {}
		end

		path = path[v]
	end

	return path
end