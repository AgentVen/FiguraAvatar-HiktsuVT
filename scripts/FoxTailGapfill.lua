---@class FoxTailGapfill #Adjusts the vertex positions of the "Gapfill" parts on the Tail primarily for when the tail is being animated.

---TODO

local TAIL = models.models.base.root.Body.Tail


local VertexFaceGroups = {}

local function initSetup()

	local workingVertexFaceGroup = {}
	for i = 1, #TAIL:getVertices("models.base.tail") do
		table.insert(workingVertexFaceGroup, TAIL:getVertices("models.base.tail")[i])

		if i % 4 == 0 then
			-- Push (clone contents of) working table to main.
			local pos = #VertexFaceGroups + 1
			VertexFaceGroups[pos] = {}
			for ii,v in pairs(workingVertexFaceGroup) do
				VertexFaceGroups[pos][ii] = v
			end

			-- Clear working table
			if #workingVertexFaceGroup > 0 then
				repeat table.remove(workingVertexFaceGroup, 1)
				until #workingVertexFaceGroup <= 0
			end
		end
	end

	-- This shouldn't ever happen.
	-- Figura has made it a point that *ALL* faces have 4 Vertexes, even ones that only need 3.
	-- 
	-- But, on the off chance it does happen, we should get informed about it.
	if #workingVertexFaceGroup > 0 then
		error("Uncompleted VertexFaceGroup. (a group of "..#workingVertexFaceGroup.." was found, from "..workingVertexFaceGroup[1].." to "..workingVertexFaceGroup[#workingVertexFaceGroup]..".)", 3)
	end
end

events.ENTITY_INIT:register(initSetup)

-- DEBUG for testing and setup of what vertex is what.
-- Because the people behind Figura desided to just 
--  put all vertexes in one big numbered list.
-- 
-- Not even with any identifible features! Not even 
--  something like `<object-name>.<face>.<vertex-number>`.
-- Just HAD to just throw all of them in one table!?
-- 
-- The only good thing is that vertexes of the same face 
--  are listed sequence of each other, and that those 
--  vertex groups that are of the same object are listed 
--  in sequence of each other.
events.KEY_PRESS:register(function(key, state)
	if key == 302 and state == 1 then --press F13 (SteelSeries + F1)
		--printTable(TAIL.cube:getAllVertices(), 3)
		printTable(TAIL.cube:getVertices("models.base.tail")[DEBUG_vert_index])

		initSetup()
	end
end)


-- Continuesly update vertex position. Especially while the tail is being animated.
events.RENDER:register(function()
	---TODO
end)