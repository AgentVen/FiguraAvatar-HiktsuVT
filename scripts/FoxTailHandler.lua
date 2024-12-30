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

local VERTEX_PAIRINGS = {
	-- Vertex #1+ are set to the position of Vertex #0
	{ [0] = "1gNUE", "0fUSE", "0fESU" },
	{ [0] = "1gNUW", "0fUSW", "0fWSU" },
	{ [0] = "1gNDE", "0fDSE", "0fESD" },
	{ [0] = "1gNDW", "0fDSW", "0fWSD" };

	{ [0] = "2gNUE", "1fUSE", "1fESU" },
	{ [0] = "2gNUW", "1fUSW", "1fWSU" },
	{ [0] = "2gNDE", "1fDSE", "1fESD" },
	{ [0] = "2gNDW", "1fDSW", "1fWSD" };

	{ [0] = "3gNUE", "2fUSE", "2fESU" },
	{ [0] = "3gNUW", "2fUSW", "2fWSU" },
	{ [0] = "3gNDE", "2fDSE", "2fESD" },
	{ [0] = "3gNDW", "2fDSW", "2fWSD" };

	{ [0] = "3gSUE", "4fUNE", "4fENU" },
	{ [0] = "3gSUW", "4fUNW", "4fWNU" },
	{ [0] = "3gSDE", "4fDNE", "4fEND" },
	{ [0] = "3gSDW", "4fDNW", "4fWND" };

	{ [0] = "4gSUE", "5fUNE", "5fENU" },
	{ [0] = "4gSUW", "5fUNW", "5fWNU" },
	{ [0] = "4gSDE", "5fDNE", "5fEND" },
	{ [0] = "4gSDW", "5fDNW", "5fWND" };

	{ [0] = "5gSUE", "6fUNE", "6fENU" },
	{ [0] = "5gSUW", "6fUNW", "6fWNU" },
	{ [0] = "5gSDE", "6fDNE", "6fEND" },
	{ [0] = "5gSDW", "6fDNW", "6fWND" };
}




local function addVerticeOriginVectors()
	-- Add origin pos, uv, and normal vectors to vertices defined in VERTICES table.
	for k,v in pairs(VERTICES) do
		v.originPos = v.Part:getVertices(TEXTURE)[v.VertexNumber]:getPos()
		v.originUV = v.Part:getVertices(TEXTURE)[v.VertexNumber]:getUV()
		v.originNormal = v.Part:getVertices(TEXTURE)[v.VertexNumber]:getNormal()
	end
end


events.ENTITY_INIT:register(function()
	addVerticeOriginVectors()
end, "FoxTailHandler")


local function applyVertexPairing(vertex_pairing)
	
end


events.RENDER:register(function (delta, context, matrix)

	for i = 0, #TAIL, 1 do
		local Theta = TAIL[i]:getRot():toRad()
		local r = vec(
			(VERTICES[i.."UNW"].originPos.x - VERTICES[i.."UNE"].originPos.x) / 2, 
			(VERTICES[i.."ENU"].originPos.y - VERTICES[i.."END"].originPos.y) / 2
		)

		VERTICES[i.."USW"].Part:getVertices(TEXTURE)[VERTICES[i.."USW"].VertexNumber]:setPos(
			math.cos(Theta.x) * r.x,
			math.sin(Theta.y) * r.y,
			math.sin(Theta.x) * r.x
		)
	end

end, "FoxTailHandler")




--DEBUG
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
		
		--printTable(TAIL[1].Base:getVertices(TEXTURE)[15], 2)
		print(TAIL[1].Base:getVertices(TEXTURE)[15]:getPos())
		print(TAIL[1].Base:getVertices(TEXTURE)[15]:getUV())
		print(TAIL[1].Base:getVertices(TEXTURE)[15]:getNormal())

	end
end, "FoxTailHandler-DEBUG")