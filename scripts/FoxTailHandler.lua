---@class KisuneMaskClass #


local TAIL = {
	[0] = models.models.base.root.Body.Tail,
	[1] = models.models.base.root.Body.Tail.Tail_1,
	[2] = models.models.base.root.Body.Tail.Tail_1.Tail_2,
	[3] = models.models.base.root.Body.Tail.Tail_1.Tail_2.Tail_3,
	[4] = models.models.base.root.Body.Tail.Tail_1.Tail_2.Tail_3.Tail_4,
	[5] = models.models.base.root.Body.Tail.Tail_1.Tail_2.Tail_3.Tail_4.Tail_5,
	[6] = models.models.base.root.Body.Tail.Tail_1.Tail_2.Tail_3.Tail_4.Tail_5.Tail_6
}
local TEXTURE = "textures.tail"


-- Ok, so I figured out why it wasn't working. 
-- 
-- It's because the positions of vertices on a Mesh are *realitive* to 
--  their own *unique* 0,0,0 point, which is initally set to the 
--  "Model Space"'s 0,0,0 point. 
-- I say "initally set" because once at runtime the point's position in 
--  the "Model Space" *becomes* realitive to the Mesh, meaning changes 
--  to the Mesh's position and/or rotation would not change the 
--  positions of the vertices.
-- 
-- Now, I'm not calling to change this. In fact I understand why its done this way.
-- However, some documentation on this quirk would've been nice. (Then again no
--  iteration of the documentation on Vertices is anymore than a stub..)
-- 
-- 
-- But now, I know what I need to do get this finally working!
-- And it's the ton of math I was originally trying to advoid.


local VERTICES = {
	NORTHSIDE = {
		["EU"] = 5,	["WU"] = 11,	["UE"] = 3,	["DE"] = 14,
		["ED"] = 8,	["WD"] = 12,	["UW"] = 4,	["DW"] = 13
	};
	SOUTHSIDE = {
		["EU"] = 6,	["WU"] = 10,	["UE"] = 2,	["DE"] = 15,
		["ED"] = 7,	["WD"] = 9,	["UW"] = 1,	["DW"] = 16
	}
}


events.ENTITY_INIT:register(function()

	---

end, "FoxTailHandler.lua-ENTITY_INIT")


local flip = {
	UpDown = { ["U"] = "D", ["D"] = "U" };
	NorthSouth = { ["N"] = "S", ["S"] = "N" };
	EastWest = { ["E"] = "W", ["W"] = "E" };
};

events.RENDER:register(function (delta, context, matrix)
	
	-- Whats going on here:
		-- 
		-- 
		--                       `.                       
		--                         `.                     
		--                           `.                   
		--     TAIL BONE B             `.                 
		--                   _.---------.`.               
		--                .-º            "º-. (x,z)       
		--              ,'                   B,           
		--             /                   _/| \          
		--           ,'                 r_/  |  `,        
		-- .         |                 _/.   |z  |        
		--  `.      |'               _/ θ \  |   `|       
		--    `.    |..............<______/__|____A (x,z) 
		--      `.  |,          .'     x/y       ,|       
		--        `.:|        .'                 |:       
		--          ::,     .'                  ,':       
		--          : `\  .'                   /  :       
		--          :   `.                   ,'   :       
		--          :     `-._           _.-'     :       
		--          :         °---------°         :       
		--          :                             :       
		--          :         TAIL BONE A         :       
		-- 

	--[=[
	do -- Example math code

		local Theta = TAIL[1]:getRot():toRad() --NOTE: `getRot` should be replaced with `getAnimRot`

		local rX = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["UNE"]]:getPos().x
		local rx = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["UNW"]]:getPos().x
		local rY = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["ENU"]]:getPos().y
		local ry = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["END"]]:getPos().y
		local r = vec((rX - rx) / 2, (rY - ry) / 2)
		
		local originPos = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["UNE"]]:getPos()
		
		TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["USE"]]:setPos(
			math.cos(Theta.x) * r.x,
			originPos.y + (((Theta.y ~= 0 ) and math.cos(Theta.y)) or Theta.y) * r.y,
			originPos.z + math.abs(math.sin(Theta.x) * r.x)
		)

	end

	do -- Example math code

		local Theta = TAIL[1]:getRot():toRad() --NOTE: `getRot` should be replaced with `getAnimRot`

		local rX = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["UNW"]]:getPos().x
		local rx = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["UNE"]]:getPos().x
		local rY = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["WNU"]]:getPos().y
		local ry = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["WND"]]:getPos().y
		local r = vec((rX - rx) / 2, (rY - ry) / 2)
		
		local originPos = TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["UNW"]]:getPos()
		
		TAIL[0].gapfill:getVertices(TEXTURE)[VERTICES["USW"]]:setPos(
			math.cos(Theta.x) * r.x,
			originPos.y + (((Theta.y ~= 0 ) and math.cos(Theta.y)) or Theta.y) * r.y,
			originPos.z + math.abs(math.sin(Theta.x) * r.x)
		)

	end
	--]=]

	for bone = 0, #TAIL, 1 do
		if bone < 3 then
			for vertexKey, vertexIndex in pairs(VERTICES.SOUTHSIDE) do
				local Theta = TAIL[bone + 1]:getRot():toRad() --NOTE: `getRot` should be replaced with `getAnimRot`

				local rX = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey]]:getPos().x
				local rx = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey:gsub(".", flip.EastWest)]]:getPos().x
				local rY = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey:reverse()]]:getPos().y
				local ry = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey:reverse():gsub(".", flip.UpDown)]]:getPos().y
				local r = vec((rX - rx) / 2, (rY - ry) / 2)
				
				local originPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey]]:getPos()
				
				TAIL[bone].gapfill:getVertices(TEXTURE)[vertexIndex]:setPos(
					math.cos(Theta.x) * r.x,
					originPos.y + (((Theta.y ~= 0 ) and math.cos(Theta.y)) or Theta.y) * r.y,
					originPos.z + math.abs(math.sin(Theta.x) * r.x)
				)
			end
		--[=[elseif bone > 3 then
			for vertexKey, vertexIndex in pairs(VERTICES.NORTHSIDE) do
				local Theta = TAIL[bone]:getRot():toRad() --NOTE: `getRot` should be replaced with `getAnimRot`

				local rX = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.SOUTHSIDE[vertexKey]]:getPos().x
				local rx = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.SOUTHSIDE[vertexKey:gsub(".", flip.EastWest)]]:getPos().x
				local rY = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.SOUTHSIDE[vertexKey:reverse()]]:getPos().y
				local ry = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.SOUTHSIDE[vertexKey:reverse():gsub(".", flip.UpDown)]]:getPos().y
				local r = vec((rX - rx) / 2, (rY - ry) / 2)
				
				local originPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.SOUTHSIDE[vertexKey]]:getPos()
				
				TAIL[0].gapfill:getVertices(TEXTURE)[vertexIndex]:setPos(
					math.cos(Theta.x) * r.x,
					originPos.y + (((Theta.y ~= 0 ) and math.cos(Theta.y)) or Theta.y) * r.y,
					originPos.z + math.abs(math.sin(Theta.x) * r.x)
				)
			end--]=]
		end
	end

	

end, "FoxTailHandler-RENDER")


local rotDirection = { 1, 1, 1}
events.TICK:register(function()

	for bone = 1, 3, 1 do
		if rotDirection[bone] > 0 then
			TAIL[bone]:setRot(TAIL[bone]:getRot() + vec(1, 0, 0))

			if TAIL[bone]:getRot().x >= 90 / 3 then
				rotDirection[bone] = -1
			end
		elseif rotDirection[bone] < 0 then
			TAIL[bone]:setRot(TAIL[bone]:getRot() - vec(1, 0, 0))

			if TAIL[bone]:getRot().x <= -90 / 3 then
				rotDirection[bone] = 1
			end
		end
	end

end, "FoxTailHandler-TICK")




-- DEBUG
local PART = TAIL[5].gapfill

local FaceGroups = { {} }

local face,index = 1,0
local OFFSET = vec(1, 1, 1)

local save = {}

events.KEY_PRESS:register(function(key, state, modifiers)
	if key == 302 and state == 1 then
		
		for i = 1, #PART:getVertices(TEXTURE) do
			table.insert(FaceGroups[face], i)

			if i % 4 == 0 and i ~= #PART:getVertices(TEXTURE) then
				face = face + 1
				FaceGroups[face] = {}
			end
		end
		face = 0

		print(#FaceGroups.." / "..#PART:getVertices(TEXTURE))

	elseif key == 303 and state == 1 then

		if face ~= 0 then
			if save[0] then
				save[0] = nil
			end

			for i = 1, #FaceGroups[face], 1 do
				PART:getVertices(TEXTURE)[FaceGroups[face][i]]:setPos(save[i])
			end
		end

		face = face + 1
		if face > #FaceGroups then
			face = 1
		end
		index = FaceGroups[face][1] - 1

		print("#"..face)

		for i = 1, #FaceGroups[face], 1 do
			save[i] = PART:getVertices(TEXTURE)[FaceGroups[face][i]]:getPos()
			PART:getVertices(TEXTURE)[FaceGroups[face][i]]:setPos(save[i] + OFFSET)

			print(FaceGroups[face][i])
		end

	elseif key == 304 and state == 1 then

		if index ~= 0 and save[0] ~= nil then
			PART:getVertices(TEXTURE)[index]:setPos(save[0])
		end

		index = index + 1
		if index > #PART:getVertices(TEXTURE) then
			index = 1
		end

		save[0] = PART:getVertices(TEXTURE)[index]:getPos()
		PART:getVertices(TEXTURE)[index]:setPos(save[0] + OFFSET)

		print(index)

	elseif key == 305 and state == 1 then

		face = 0
		index = 0

	end
end, "FoxTailHandler-DEBUG")