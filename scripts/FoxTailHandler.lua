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


local flip = {
	UpDown = { ["U"] = "D", ["D"] = "U" };
	NorthSouth = { ["N"] = "S", ["S"] = "N" };
	EastWest = { ["E"] = "W", ["W"] = "E" };
};



local enableDEBUG = false


events.RENDER:register(function (delta, context, matrix)
	
	do -- TEMP DEBUG
		TAIL[0].Base:setOpacity(0.5)
		TAIL[1].Base:setOpacity(0.5)
		TAIL[2].Base:setOpacity(0.5)
		TAIL[3].Base:setOpacity(0.5)
		TAIL[4].Base:setOpacity(0.5)
		TAIL[5].Base:setOpacity(0.5)
		TAIL[6].Base:setOpacity(0.5)
	end

	-- Whats going on here:
	-- 
	-- 
	--                        `.                       
	--                          `.                     
	--                            `.                   
	--        TAIL[B]               `.                 
	--                   _.----------.`.               
	--                .-º             "º-. (x,z)       
	--              ,'                   _B,           
	--             /                   _/ | \          
	--           ,'                 r_/   |  `,        
	-- .         |                 _/.    |z  |        
	--  `.      |'               _/ θ \   |   `|       
	--    `.    |...............<_____/___|____A (x,z) 
	--      `.  |,          .'       x        ,|       
	--        `.:|        .'                  |:       
	--          ::,     .'                   ,':       
	--          : `\  .'                    /  :       
	--          :   `.                    ,'   :       
	--          :     `-._            _.-'     :       
	--          :         °----------°         :       
	--          :                              :       
	--          :            TAIL[A]           :       
	-- 
	--
	-- Since we can't correct the vertex position by getting the position of a vertex on a different Mesh,
	--  we need to use math to get the position.
	-- 
	-- Specifically, what we need is to get a point on a circumference from an angle.
	-- This can be done with Simple Trigonometry and a mathematically-existing circle.
	-- 
	-- 
	-- For rotation on the x-axis (Side-to-Side):
	-- 
	--       x = cos(θ.x) * r.x     z = sin(θ.x) * r.x
	-- 
	-- For rotation on the y-axis (Up-and-Down):
	-- 
	--       y = cos(θ.y) * r.y     z = sin(θ.y) * r.y
	-- 
	-- `θ` is the rotation of TAIL[B]. 
	--  `θ.x` is the rotation of TAIL[B] on the `x` axis. 
	--  `θ.y` is the rotation of TAIL[B] on the `y` axis.
	-- `r` is the radius of the mathematically-existing circle. 
	--  `r.x` is the radius calulated on the `x` axis. 
	--  `r.y` is the radius calulated on the `y` axis.
	-- 
	-- 
	-- However, remember that the vertices are realitive to a hidden 0,0,0 point. Which initally is the 
	--  same as the "Model Space"'s 0,0,0 point, it then becomes realitive to the Part at runtime.
	-- Likely-hood is
	-- 
	-- This is done by


	-- [==[
	for bone = 0, #TAIL - 4, 1 do
		if bone < 3 then
			for vertexKey, vertexIndex in pairs(VERTICES.SOUTHSIDE) do
				local Theta = TAIL[bone + 1]:getRot():toRad() --NOTE: `getRot` should be replaced with `getAnimRot`

				local rX = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey]]:getPos().x
				local rx = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey:gsub(".", flip.EastWest)]]:getPos().x
				local rY = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey:reverse()]]:getPos().y
				local ry = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey:reverse():gsub(".", flip.UpDown)]]:getPos().y
				local r = vec(rX - rx, rY - ry):div(2, 2)


				local originPos = vec(
					(math.max(rX, rx) - math.abs(r.x)),
					(math.max(rY, ry) - math.abs(r.y)),
					TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES.NORTHSIDE[vertexKey]]:getPos().z
				)

				local newPos = vec(
					originPos.x + (math.cos(Theta.x) * r.x),
					originPos.y + (math.cos(Theta.y) * r.y),
					originPos.z + (
 						math.sin(Theta.x) * r.x + math.sin(Theta.y) * r.y
 					)
				)

				if newPos.z <= originPos.z then
					newPos = originPos
				end

				TAIL[bone].gapfill:getVertices(TEXTURE)[vertexIndex]:setPos(newPos)


				if enableDEBUG then
					do
						local sysTime = client:getSystemTime()
						local seconds = math.floor(sysTime / 1000)
						local milliseconds = sysTime % 1000
						local minutes = math.floor(seconds / 60)
						seconds = seconds % 60
						local hours = math.floor(minutes / 60)
						minutes = minutes % 60

						print(string.format("\n< @%02d:%02d:%02d.%03d >", hours, minutes, seconds, milliseconds))
					end


					print("\"bone\" :",bone, "\"vertexKey\" :",vertexKey, "\"vertexIndex\" :",vertexIndex)
					print("\"Theta\" :",Theta:toDeg(), Theta)
					print("\"rX\" :",rX, "\"rx\" :",rx, "\"rY\" :",rY, "\"ry\" :",ry)
					print("\"r\" :",r)
					print("\"originPos\" :",originPos)
					print("[Final-Vertex-Pos-X] :", "cos(", Theta.x, ")", "=", math.cos(Theta.x), "*", r.x)
					print("[Final-Vertex-Pos-Y] :", "cos(", Theta.y, ")", "=", math.cos(Theta.y), "*", originPos.y)
					print("Final-Vertex-Pos :",TAIL[bone].gapfill:getVertices(TEXTURE)[vertexIndex]:getPos())
				end

			end
		--[=[
		elseif bone > 3 then
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
	end--]==]

	

end, "FoxTailHandler-RENDER")

local rotX,rotY = 0,0
local targetRot = vec(90, 90, 0):div(3, 3, 0)
events.TICK:register(function()

	for bone = 1, #TAIL - 3, 1 do
		local rot = TAIL[bone]:getRot()

		--if rot.x ~= targetRot.x then

			if (rotX == 1) and rot.x < targetRot.x then
				TAIL[bone]:setRot(rot + vec(1, 0, 0))
			elseif (rotX == -1) and rot.x > -targetRot.x then
				TAIL[bone]:setRot(rot - vec(1, 0, 0))
			end

			--if TAIL[bone]:getRot().x == targetRot.x then
			--	targetRot = targetRot:mul(1, -1, 1)
			--end

		--elseif rot.y ~= targetRot.y then

			if (rotY == 1) and rot.y < targetRot.y then
				TAIL[bone]:setRot(rot + vec(0, 1, 0))
			elseif (rotY == -1) and rot.y > -targetRot.y then
				TAIL[bone]:setRot(rot - vec(0, 1, 0))
			end

			--if TAIL[bone]:getRot().y == targetRot.y then
			--	targetRot = targetRot:mul(-1, 1, 1)
			--end

		--end
	end

end, "FoxTailHandler-TICK")


-- DEBUG
local PART = TAIL[0].gapfill

local FaceGroups = { {} }

local face,index = 1,0
local OFFSET = vec(0, 1, 0)

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
		
		enableDEBUG = not enableDEBUG

	elseif key == 262 then
		if state >= 1 then
			rotX = -1
		else
			rotX = 0
		end
	elseif key == 263 then
		if state >= 1 then
			rotX = 1
		else
			rotX = 0
		end
	elseif key == 264 then
		if state >= 1 then
			rotY = -1
		else
			rotY = 0
		end
	elseif key == 265 then
		if state >= 1 then
			rotY = 1
		else
			rotY = 0
		end
	end
end, "FoxTailHandler-DEBUG")