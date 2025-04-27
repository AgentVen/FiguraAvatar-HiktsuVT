---@class PhysicsTask
---@field ModelPart ModelPart
---@field Name string
local PhysicsTask_Template = {
	ModelPart = nil,
	Name = ""
}




---@type PhysicsTask[]
local physicsTasks = {}

---@param modelPart ModelPart
---@return PhysicsTask[] physicsTasksSubset
local function isolatePhysicsTasksBelongingToASpecificModelPart(modelPart)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(modelPart))
		)
	end

	local physicsTasksSubset = {}

	for entry, physicsTask in pairs(physicsTasks) do
		if physicsTask.ModelPart == modelPart then
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
---@param modelPart ModelPart
---@param taskName? string # The name of the Physics Task to get.
---@return (PhysicsTask?)|string[]
local function getPhysicsTask(modelPart, taskName)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(modelPart))
		)

		assert(type(taskName) == 'string' or type(taskName) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): 'string', or 'nil'. Got type: '%s'.)"):format(type(taskName))
		)
	end

	local physicsTasksSubset = isolatePhysicsTasksBelongingToASpecificModelPart(modelPart)

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
---@param modelPart ModelPart
---@param taskName string # The name of this Physics Task.
---@return PhysicsTask newPhysicsTask
local function newPhysicsTask(modelPart, taskName)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(modelPart))
		)

		assert(type(taskName) == 'string',
		("Bad argument #2; Invalid type! (Expected type(s): 'string'. Got type: '%s'.)"):format(type(taskName))
		)
		assert(taskName ~= "" and taskName:len() > 0,
		"Bad argument #2; Empty string!"
		)
		assert(not getPhysicsTask(modelPart, taskName),
		("There already exists a Physics Task named: \"%s\" for this Model Part."):format(taskName)
		)
	end

	---@type PhysicsTask
	local physicsTask = table.clone(PhysicsTask_Template, -1)
	physicsTask.ModelPart = modelPart
	physicsTask.Name = taskName
	
	-- TODO: the reset of the Physics Task setup

	table.insert(physicsTasks, physicsTask)
	return physicsTask
end

---Adds the given Physics Task on this Part
---@param modelPart ModelPart
---@param physicsTask PhysicsTask
---@return PhysicsTask addedPhysicsTask
local function addPhysicsTask(modelPart, physicsTask)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(modelPart))
		)

		assert(type(physicsTask) == 'PhysicsTask',
		("Bad argument #2; Invalid type! (Expected type(s): 'PhysicsTask'. Got type: '%s'.)"):format(type(physicsTask))
		)
	end

	---@type PhysicsTask
	local physicsTaskClone = table.clone(physicsTask, -1)
	physicsTaskClone.ModelPart = modelPart

	-- TODO: the reset of the Physics Task re-setup

	table.insert(physicsTasks, physicsTaskClone)
	return physicsTaskClone
end

---Removes the Task with the given name from this part.
---
---Removes ALL task if a name is not given.
---@param modelPart ModelPart
---@param physicsTask? PhysicsTask|string # Either the `PhysicsTask` object or its name.
local function removePhysicsTask(modelPart, physicsTask)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
		("Bad argument #1; Invalid type! (Expected type(s): 'ModelPart'. Got type: '%s'.)"):format(type(modelPart))
		)

		assert(type(physicsTask) == 'PhysicsTask' or type(physicsTask) == 'string' or type(physicsTask) == 'nil',
		("Bad argument #2; Invalid type! (Expected type(s): 'PhysicsTask', 'string', or 'nil'. Got type: '%s'.)"):format(type(physicsTask))
		)
	end

	local physicsTasksSubset = isolatePhysicsTasksBelongingToASpecificModelPart(modelPart)

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
		physicsTask = getPhysicsTask(modelPart, physicsTask)
	end

	for e,v in pairs(physicsTasksSubset) do
		if v.Name == physicsTask.Name then
			table.remove(physicsTask, prePhysicsTaskEntryRemoval(e))
		end
	end

	-- TODO-MAYBE: Include a return of the modelPart for chaining like with the Render Task `removeTask()`.
end