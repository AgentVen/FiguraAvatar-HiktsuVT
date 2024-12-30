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
	["EUN"] = 5,	["WUN"] = 11,	["UNE"] = 3,	["DNE"] = 14,
	["EUS"] = 6,	["WUS"] = 10,	["UNW"] = 4,	["DNW"] = 13,
	["EDN"] = 8,	["WDN"] = 12,	["USE"] = 2,	["DSE"] = 15,
	["EDS"] = 7;	["WDS"] = 9;	["USW"] = 1;	["DSW"] = 16;
}



events.RENDER:register(function (delta, context, matrix)
	do -- Example math code
		local Theta = TAIL[1]:getRot():toRad()

		local rX = TAIL[0]:getVertices(TEXTURE)[VERTICES["UNW"]]:getPos().x
		local rx = TAIL[0]:getVertices(TEXTURE)[VERTICES["UNE"]]:getPos().x
		local rY = TAIL[0]:getVertices(TEXTURE)[VERTICES["EUN"]]:getPos().y
		local ry = TAIL[0]:getVertices(TEXTURE)[VERTICES["EDN"]]:getPos().y
		local r = vec((rX - rx) / 2, (rY - ry) / 2)

		TAIL:getVertices(TEXTURE)[VERTICES["USW"]]:setPos(
			math.cos(Theta.x) * r.x,
			math.sin(Theta.y) * r.y,
			math.sin(Theta.x) * r.x
		)
	end





end, "FoxTailHandler-RENDER")




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

		index = 0
		face = 0

	end
end, "FoxTailHandler-DEBUG")