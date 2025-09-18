local ModelPart_libx = require("scripts/utils/lib/ModelPart_libx")


---@enum PhysicsTask.PhysicsOffset.Modifier
Enum:createDir("PhysicsTask.PhysicsOffset").Modifier = {
	None = 0,
	Elastic = 1,
	Bounce = 2,
	Stretch = 3,
	--TODO
}

---@class PhysicsTask
---@field Parent ModelPart # **`LET-BE-READ-ONLY`**
---@field Name string # **`LET-BE-READ-ONLY`**
---@field PhysicsOffsetPos_Origin Vector3 # **`LET-BE-READ-ONLY`** *(See: `:setPhysicsOffsetPosOrigin()`)*
---@field PhysicsOffsetRot_Origin Vector3 # **`LET-BE-READ-ONLY`** *(See: `:setPhysicsOffsetRotOrigin()`)*
---@field PhysicsOffsetScale_Origin Vector3 # **`LET-BE-READ-ONLY`** *(See: `:setPhysicsOffsetScaleOrigin()`)*
local PhysicsTask_Template = {
	Parent = nil,
	Name = "",
	PhysicsOffsetPos = {
		Origin = vec(0, 0, 0),
		Multiplier = vec(1, 1, 1),
		Modifier = Enum.PhysicsTask.PhysicsOffset.Modifier.None,
	},
	PhysicsOffsetRot = {
		Origin = vec(0, 0, 0),
		Multiplier = vec(1, 1, 1),
		Modifier = Enum.PhysicsTask.PhysicsOffset.Modifier.None,
	},
	PhysicsOffsetScale = {
		Origin = vec(0, 0, 0),
		Multiplier = vec(1, 1, 1),
		Modifier = Enum.PhysicsTask.PhysicsOffset.Modifier.None,
	},
}


-- GET PHYSICS OFFSETS

---### `INTERNAL`[^1] `YIELD`[^2]
---Calculates and returns the Physics Offset Position.
---@param delta number
---@param context Event.Render.context
---@return Vector3 physicsOffsetPos # The calculated physics offset position.
---[^1]: While mainly used internally, feel free to use it if need be.
---<br>[^2]: Potentially long yield.
function PhysicsTask_Template:getPhysicsOffsetPos(delta, context)
	--TODO
end

---### `INTERNAL`[^1] `YIELD`[^2]
---Calculates and returns the Physics Offset Rotation.
---@param delta number
---@param context Event.Render.context
---@return Vector3 physicsOffsetRot # The calculated physics offset rotation.
---[^1]: While mainly used internally, feel free to use it if need be.
---<br>[^2]: Potentially long yield.
function PhysicsTask_Template:getPhysicsOffsetRot(delta, context)
	--TODO
end

---### `INTERNAL`[^1] `YIELD`[^2]
---Calculates and returns the Physics Offset Scale.
---@param delta number
---@param context Event.Render.context
---@return Vector3 physicsOffsetScale # The calculated physics offset scale.
---[^1]: While mainly used internally, feel free to use it if need be.
---<br>[^2]: Potentially long yield.
function PhysicsTask_Template:getPhysicsOffsetScale(delta, context)
	--TODO
end


-- SET PHYSICS OFFSETS ENABLED

---Set whether or not Physics Offset Position calculations should be enabled.
---@param enabled boolean
function PhysicsTask_Template:setPhysicsOffsetPosEnabled(enabled)
	do -- Type checking & correction
		assert(type(enabled) == 'boolean',
		("Bad argument #1; Invalid type! (Expected type(s): 'boolean'. Got type '%s'.)"):format(type(enabled))
		)
	end

	local eventName = ModelPart_libx.getFullName(self.Parent).."."..self.Name..":".."PhysicsOffsetPos-RENDER"

	local existingEvents = events.RENDER:getRegisteredCount(eventName)
	if enabled and existingEvents < 1 then
		events.RENDER:register(function(delta, context)

			self:getPhysicsOffsetPos(delta, context)

		end, eventName)

	elseif not enabled and existingEvents > 1 then
		events.RENDER:remove(eventName)
	end
end

---Set whether or not Physics Offset Rotation calculations should be enabled.
---@param enabled boolean
function PhysicsTask_Template:setPhysicsOffsetRotEnabled(enabled)
	do -- Type checking & correction
		assert(type(enabled) == 'boolean',
		("Bad argument #1; Invalid type! (Expected type(s): 'boolean'. Got type '%s'.)"):format(type(enabled))
		)
	end

	local eventName = ModelPart_libx.getFullName(self.Parent).."."..self.Name..":".."PhysicsOffsetRot-RENDER"

	local existingEvents = events.RENDER:getRegisteredCount(eventName)
	if enabled and existingEvents < 1 then
		events.RENDER:register(function(delta, context)

			self:getPhysicsOffsetRot(delta, context)

		end, eventName)

	elseif not enabled and existingEvents > 1 then
		events.RENDER:remove(eventName)
	end
end

---Set whether or not Physics Offset Scale calculations should be enabled.
---@param enabled boolean
function PhysicsTask_Template:setPhysicsOffsetScaleEnabled(enabled)
	do -- Type checking & correction
		assert(type(enabled) == 'boolean',
		("Bad argument #1; Invalid type! (Expected type(s): 'boolean'. Got type '%s'.)"):format(type(enabled))
		)
	end

	local eventName = ModelPart_libx.getFullName(self.Parent).."."..self.Name..":".."PhysicsOffsetScale-RENDER"

	local existingEvents = events.RENDER:getRegisteredCount(eventName)
	if enabled and existingEvents < 1 then
		events.RENDER:register(function(delta, context)

			self:getPhysicsOffsetScale(delta, context)

		end, eventName)

	elseif not enabled and existingEvents > 1 then
		events.RENDER:remove(eventName)
	end
end


-- IS PHYSICS OFFSETS ENABLED

---Returns boolean value as to if Physics Offset Position calculations are enabled.
---@return boolean
function PhysicsTask_Template:isPhysicsOffsetPosEnabled()
	local eventName = ModelPart_libx.getFullName(self.Parent).."."..self.Name..":".."PhysicsOffsetPos-RENDER"

	return (events.RENDER:getRegisteredCount(eventName) > 1)
end

---Returns boolean value as to if Physics Offset Rotation calculations are enabled.
---@return boolean
function PhysicsTask_Template:isPhysicsOffsetRotEnabled()
	local eventName = ModelPart_libx.getFullName(self.Parent).."."..self.Name..":".."PhysicsOffsetRot-RENDER"

	return (events.RENDER:getRegisteredCount(eventName) > 1)
end

---Returns boolean value as to if Physics Offset Scale calculations are enabled.
---@return boolean
function PhysicsTask_Template:isPhysicsOffsetScaleEnabled()
	local eventName = ModelPart_libx.getFullName(self.Parent).."."..self.Name..":".."PhysicsOffsetScale-RENDER"

	return (events.RENDER:getRegisteredCount(eventName) > 1)
end


-- SET PHYSICS OFFSETS ORIGIN

---Sets the physics offset position origin for the Physics Task.
---
---This should be the position at which the physics simulation should be at rest, or to put it simply, 
---the position that gravity is trying to bring it to.
---
---The origin ultimately behaves as the 0-0-0-point for the physics offset position, as a "origin" vector should. 
---<br>If `:getPhysicsOffsetPos()` returns `vec(0, 0, 0)`, that's this.
---
---Note, that this is relative to the Physics Task's parent part's position.
---@param x number|Vector3 # Either the "x" vector or a `Vector3` object.
---@param y number|nil # Must be `nil` if x is an `Vector3` object.
---@param z number|nil # Must be `nil` if x is an `Vector3` object.
function PhysicsTask_Template:setPhysicsOffsetPosOrigin(x, y, z)
	do -- Type checking & correction
		assert(type(x) == 'number' or type(x) == 'Vector3',
		("Bad argument #1; Invalid type! (Expected type(s): 'number', or 'Vector3'. Got type: '%s'.)"):format(type(x))
		)
		local isX = (type(x) == 'number')

		assert((isX and type(y) == 'number') or type(y) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): '%s'. Got type: '%s'.)"):format((isX and "number") or "nil", type(y))
		)

		assert((isX and type(z) == 'number') or type(z) == 'nil',
		("Bad argument #3; Invalid type! (Expected type(s): '%s'. Got type: '%s'.)"):format((isX and "number") or "nil", type(z))
		)

		y = y or x.y
		z = z or x.z
		x = (isX and x) or x.x


	end

	self.PhysicsOffsetPosOrigin = vec(x, y, z)
	--TODO: whatever other stuff that is needed to be done.
end

---Sets the physics offset rotation origin for the Physics Task.
---
---This should be the rotation at which the physics simulation should be at rest, or to put it simply, 
---the rotation that gravity is trying to bring it to.
---
---The origin ultimately behaves as the 0-0-0-point for the physics offset rotation, as a "origin" vector should. 
---<br>If `:getPhysicsOffsetRot()` returns `vec(0, 0, 0)`, that's this.
---
---Note, that this is relative to the Physics Task's parent part's rotation.
---@param x number|Vector3 # Either the "x" vector or a `Vector3` object.
---@param y number|nil # Must be `nil` if x is an `Vector3` object.
---@param z number|nil # Must be `nil` if x is an `Vector3` object.
function PhysicsTask_Template:setPhysicsOffsetRotOrigin(x, y, z)
	do -- Type checking & correction
		assert(type(x) == 'number' or type(x) == 'Vector3',
		("Bad argument #1; Invalid type! (Expected type(s): 'number', or 'Vector3'. Got type: '%s'.)"):format(type(x))
		)
		local isX = (type(x) == 'number')

		assert((isX and type(y) == 'number') or type(y) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): '%s'. Got type: '%s'.)"):format((isX and "number") or "nil", type(y))
		)

		assert((isX and type(z) == 'number') or type(z) == 'nil',
		("Bad argument #3; Invalid type! (Expected type(s): '%s'. Got type: '%s'.)"):format((isX and "number") or "nil", type(z))
		)

		y = y or x.y
		z = z or x.z
		x = (isX and x) or x.x


	end

	self.PhysicsOffsetRotOrigin = vec(x, y, z)
	--TODO: whatever other stuff that is needed to be done.
end

---Sets the physics offset scale origin for the Physics Task.
---
---This should be the scale at which the physics simulation should be at rest, or to put it simply, 
---the scale that gravity is trying to bring it to.
---
---The origin ultimately behaves as the 0-0-0-point for the physics offset scale, as a "origin" vector should. 
---<br>If `:getPhysicsOffsetScale()` returns `vec(0, 0, 0)`, that's this.
---
---Note, that this is relative to the Physics Task's parent part's scale.
---@param x number|Vector3 # Either the "x" vector or a `Vector3` object.
---@param y number|nil # Must be `nil` if x is an `Vector3` object.
---@param z number|nil # Must be `nil` if x is an `Vector3` object.
function PhysicsTask_Template:setPhysicsOffsetScaleOrigin(x, y, z)
	do -- Type checking & correction
		assert(type(x) == 'number' or type(x) == 'Vector3',
		("Bad argument #1; Invalid type! (Expected type(s): 'number', or 'Vector3'. Got type: '%s'.)"):format(type(x))
		)
		local isX = (type(x) == 'number')

		assert((isX and type(y) == 'number') or type(y) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): '%s'. Got type: '%s'.)"):format((isX and "number") or "nil", type(y))
		)

		assert((isX and type(z) == 'number') or type(z) == 'nil',
		("Bad argument #3; Invalid type! (Expected type(s): '%s'. Got type: '%s'.)"):format((isX and "number") or "nil", type(z))
		)

		y = y or x.y
		z = z or x.z
		x = (isX and x) or x.x


	end

	self.PhysicsOffsetScaleOrigin = vec(x, y, z)
	--TODO: whatever other stuff that is needed to be done.
end



-- Module functions

---@type PhysicsTask[]
local physicsTasks = {}

---@param parent ModelPart
---@return PhysicsTask[] physicsTasksSubset
local function isolatePhysicsTasksBelongingToASpecificParent(parent)
	do -- Type checking & correction
		assert(type(parent) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(parent))
		)
	end

	local physicsTasksSubset = {}

	for entry, physicsTask in pairs(physicsTasks) do
		if physicsTask.Parent == parent then
			physicsTasksSubset[entry] = physicsTask
		end
	end

	return physicsTasksSubset
end

---@param entry integer
---@return integer entry
local function prePhysicsTaskEntryRemoval(entry)
	-- TODO: Disabling & resetting everything related to PhysicsTask.
	return entry
end

---Gets the Physics Task with the given name from this part.
---
---Returns a table with all Physics Tasks if a name is not given.
---@param parent ModelPart
---@param taskName? string # The name of the Physics Task to get.
---@return (PhysicsTask?)|string[]
local function getPhysicsTask(parent, taskName)
	do -- Type checking & correction
		assert(type(parent) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(parent))
		)

		assert(type(taskName) == 'string' or type(taskName) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): 'string', or 'nil'. Got type: '%s'.)"):format(type(taskName))
		)
		assert(taskName ~= "" and taskName:len() > 0,
		"Bad argument #2; Empty string!"
		)
	end

	local physicsTasksSubset = isolatePhysicsTasksBelongingToASpecificParent(parent)

	if type(taskName) == 'string' then
		if #physicsTasksSubset > 0 then
			for _,physicsTask in pairs(physicsTasksSubset) do
				if physicsTask.Name == taskName then
					return physicsTask
				end
			end
		end
		return nil
	end

	-- If taskName is nil, list all existing Physics Tasks.
	local taskList = {}
	if #physicsTasksSubset > 0 then
		for _,physicsTask in pairs(physicsTasksSubset) do
			table.insert(taskList, physicsTask.Name)
		end
	end
	return taskList
end

---Adds a new Physics Task on this part.
---@param parent ModelPart
---@param taskName string # The name of this Physics Task.
---@return PhysicsTask newPhysicsTask
local function newPhysicsTask(parent, taskName)
	do -- Type checking & correction
		assert(type(parent) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(parent))
		)

		assert(type(taskName) == 'string',
		("Bad argument #2; Invalid type! (Expected type(s): 'string'. Got type: '%s'.)"):format(type(taskName))
		)
		assert(taskName ~= "" and taskName:len() > 0,
		"Bad argument #2; Empty string!"
		)
	end

	if getPhysicsTask(parent, taskName) then
		error(("There already exists a Physics Task named: \"%s\" for this Model Part."):format(taskName), 6)
	end

	---@type PhysicsTask
	local physicsTask = table.clone(PhysicsTask_Template, -1)
	physicsTask.ModelPart = parent
	physicsTask.Name = taskName
	-- TODO: the reset of the Physics Task setup

	table.insert(physicsTasks, physicsTask)
	return physicsTask
end

---Adds the given Physics Task on this Part
---@param parent ModelPart
---@param physicsTask PhysicsTask
---@return PhysicsTask addedPhysicsTask
local function addPhysicsTask(parent, physicsTask)
	do -- Type checking & correction
		assert(type(parent) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(parent))
		)

		assert(type(physicsTask) == 'PhysicsTask',
		("Bad argument #2; Invalid type! (Expected type(s): 'PhysicsTask'. Got type: '%s'.)"):format(type(physicsTask))
		)
	end

	if physicsTask.Parent == parent then
		error("Attempted to duplicate PhysicsTasks. (Cannot add Physics Task to its source Model Part.)", 6)
	end
	
	if getPhysicsTask(parent, physicsTask.Name) then
		error(("There already exists a Physics Task named: \"%s\" for this Model Part."):format(physicsTask.Name), 6)
	end

	---@type PhysicsTask
	local physicsTaskClone = table.clone(physicsTask, -1)
	physicsTaskClone.Parent = parent
	-- TODO: the reset of the Physics Task re-setup

	table.insert(physicsTasks, physicsTaskClone)
	return physicsTaskClone
end

---Removes the Task with the given name from this part.
---
---Removes ALL task if a name is not given.
---@param parent ModelPart
---@param physicsTask? PhysicsTask|string # Either the `PhysicsTask` object or its name.
local function removePhysicsTask(parent, physicsTask)
	do -- Type checking & correction
		assert(type(parent) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(parent))
		)

		assert(type(physicsTask) == 'PhysicsTask' or type(physicsTask) == 'string' or type(physicsTask) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): 'PhysicsTask', 'string', or 'nil'. Got type: '%s'.)"):format(type(physicsTask))
		)
	end

	local physicsTasksSubset = isolatePhysicsTasksBelongingToASpecificParent(parent)

	if type(physicsTask) == 'nil' then
		for e = #physicsTasksSubset, 1, -1 do
			-- IMPORTANT: This could take a lot of time to complete!
			-- Due to us having to yelid for `prePhysicsTaskEntryRemoval()` before 
			-- removing the physics task's entry. While going in decending order, 
			-- because of how `table.remove()` works.
			-- 
			-- I have no idea what effect this would have durring runtime, 
			-- but idealy we shouldn't have to ever call `removePhysicsTask()` with a `nil`
			-- second argument outside of testing/debugging of the PhysicsTask system itself.
			table.remove(physicsTask, prePhysicsTaskEntryRemoval(e))
		end
	end


	if type(physicsTask) == 'string' then
		physicsTask = getPhysicsTask(parent, physicsTask)
	end

	for e,v in pairs(physicsTasksSubset) do
		if v.Name == physicsTask.Name then
			table.remove(physicsTask, prePhysicsTaskEntryRemoval(e))
		end
	end

	-- TODO-MAYBE: Include a return of the modelPart for chaining like with the Render Task `removeTask()`.
end

return {
	getPhysicsTask = getPhysicsTask,
	newPhysicsTask = newPhysicsTask,
	addPhysicsTask = addPhysicsTask,
	removePhysicsTask = removePhysicsTask
}