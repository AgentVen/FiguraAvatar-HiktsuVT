-- TODO:
-- Should maybe attach these to the `ModelPart` object class.
-- Like with the the methods in "scripts/utils/lib/table.lua" and "scripts/utils/lib/string.lua"


---Returns a list of the given part's ancestors, in order of closest to furthest.
---@param modelPart ModelPart
---@return ModelPart[] ancestors
local function getAncestors(modelPart)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(modelPart))
		)
	end

	local ancestors = {}

	local part = modelPart
	repeat
		if part:getParent() ~= nil then
			part = part:getParent()
			table.insert(ancestors, part)
		end
	until part:getParent() == nil

	return ancestors
end

---Gets the "Full Name" of the given model part.
---@param modelPart ModelPart
---@return string
local function getFullName(modelPart)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(modelPart))
		)
	end

	local fullName = modelPart:getName()

	local ancestors = getAncestors(modelPart)
	if #ancestors > 0 then
		for i = 1, #ancestors do
			fullName = ancestors[i].."."..fullName
		end
	end

	return "root."..fullName
end