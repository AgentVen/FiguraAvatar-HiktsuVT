---TODO


local TAIL = models.models.base.root.Body.Tail


events.KEY_PRESS:register(function(key, state)
	if key == 44 and state == 1 then
		--printTable(TAIL.cube:getAllVertices(), 3)
		printTable(TAIL.cube:getVertices("models.base.tail")[1]:getPos())
	end
end)


local vert_index = 7

local vert_pos = TAIL.cube:getVertices("models.base.tail")[vert_index]:getPos():add(1, 1, 1)

events.RENDER:register(function()
	TAIL.cube:getVertices("models.base.tail")[vert_index]:setPos(vert_pos)
end)