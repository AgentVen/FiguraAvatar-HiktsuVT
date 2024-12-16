---@class FoxTailGapfill #Adjusts the vertex positions of the "Gapfill" parts on the Tail primarily for when the tail is being animated.

---TODO

local TAIL = models.models.base.root.Body.Tail


local VertexFaceGroups = {}

local function initSetup()

	-- Create a new table in VertexFaceGroups every 4 vertices which stores said 4 vertices' index positions.
	-- 
	-- While figura's way of handling organization and identification of vertices is horid, we can at least 
	--  rely on the fact that:
	--    1. Figura makes it so that ALL faces have 4 vertices, even ones that don't need 4.
	--     (no idea if Figura also makes it so that all meshes have 6 faces, need to test)
	--    2. That they vertices of the face are listed in sequence of one another.
	-- By this we can pair up all vertices of the same face, and if the same aplies to vertices of the same
	--  object, well that will just be great.
	local pos = #VertexFaceGroups + 1
	VertexFaceGroups[pos] = {}

	for i = 1, #TAIL:getVertices("models.base.tail") do
		table.insert(VertexFaceGroups[pos], TAIL:getVertices("models.base.tail")[i])

		if i % 4 == 0 and i ~= #VertexFaceGroups then
			-- Repeat for the next 4 vertices.
			pos = #VertexFaceGroups + 1
			VertexFaceGroups[pos] = {}
		end
	end

	-- This shouldn't ever happen.
	-- Figura has made it a point that *ALL* faces have 4 vertices, even ones that only need 3.
	-- 
	-- But, on the off chance it does happen, we should get informed about it.
	if #VertexFaceGroups[pos] < 4 then
		error("Uncompleted VertexFaceGroup. (a group of "..#VertexFaceGroups[pos].."vertexes was found, created from "..VertexFaceGroups[pos][1].." to "..VertexFaceGroups[pos][#VertexFaceGroups[pos]]..".)", 3)
	end


	---TODO
	-- See if this same stuff can be used to organize faces into objects.
end

events.ENTITY_INIT:register(initSetup)

-- DEBUG for testing and setup of what vertex is what.
-- Because the people behind Figura desided to just 
--  put all vertices in one big numbered list.
-- 
-- Not even with any identifible features! Not even 
--  something like `<object-name>.<face>.<vertex-number>`.
-- Just HAD to just throw all of them in one table!?
-- 
-- The only good thing is that vertices of the same face 
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