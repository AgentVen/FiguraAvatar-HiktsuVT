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


local VERTICES = {
	--       _UN   _US
	-- 	    E/W   E/W
	-- 		+-----+
	-- 		|     |
	-- 		|     |
	-- 		|     |
	-- 		|     |
	-- 		|     |
	-- 		+-----+
	-- 	    _DN   _DS
	-- 	    E/W   E/W
	-- 
	--       _UE           _UW
	-- 	    N/S           N/S
	-- 		+-------------+
	-- 		|             |
	-- 		|             |
	-- 		|             |
	-- 		|             |
	-- 		|             |
	-- 		+-------------+
	-- 	    _DE           _DW
	-- 	    N/S           N/S

	["0fUSE"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};
	["0fESU"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};
	["0fUSW"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};
	["0fWSU"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};
	["0fDSE"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};
	["0fESD"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};
	["0fDSW"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};
	["0fWSD"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = 0
	};

	["1gNUE"] = {
		Part = TAIL[1].Base,
		VertexNumber = 0
	};
	["1gNUW"] = {
		Part = TAIL[1].Base,
		VertexNumber = 0
	};
	["1gNDE"] = {
		Part = TAIL[1].Base,
		VertexNumber = 0
	};
	["1gNDW"] = {
		Part = TAIL[1].Base,
		VertexNumber = 0
	};

	["1fUSE"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};
	["1fESU"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};
	["1fUSW"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};
	["1fWSU"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};
	["1fDSE"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};
	["1fESD"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};
	["1fDSW"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};
	["1fWSD"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = 0
	};

	["2gNUE"] = {
		Part = TAIL[2].Base,
		VertexNumber = 0
	};
	["2gNUW"] = {
		Part = TAIL[2].Base,
		VertexNumber = 0
	};
	["2gNDE"] = {
		Part = TAIL[2].Base,
		VertexNumber = 0
	};
	["2gNDW"] = {
		Part = TAIL[2].Base,
		VertexNumber = 0
	};

	["2fUSE"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};
	["2fESU"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};
	["2fUSW"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};
	["2fWSU"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};
	["2fDSE"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};
	["2fESD"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};
	["2fDSW"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};
	["2fWSD"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = 0
	};

	["3gNUE"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};
	["3gNUW"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};
	["3gNDE"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};
	["3gNDW"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};
	["3gSUE"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};
	["3gSUW"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};
	["3gSDE"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};
	["3gSDW"] = {
		Part = TAIL[3].Base,
		VertexNumber = 0
	};

	["4fUNE"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};
	["4fENU"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};
	["4fUNW"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};
	["4fWNU"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};
	["4fDNE"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};
	["4fEND"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};
	["4fDNW"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};
	["4fWND"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = 0
	};

	["4gSUE"] = {
		Part = TAIL[4].Base,
		VertexNumber = 0
	};
	["4gSUW"] = {
		Part = TAIL[4].Base,
		VertexNumber = 0
	};
	["4gSDE"] = {
		Part = TAIL[4].Base,
		VertexNumber = 0
	};
	["4gSDW"] = {
		Part = TAIL[4].Base,
		VertexNumber = 0
	};

	["5fUNE"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};
	["5fENU"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};
	["5fUNW"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};
	["5fWNU"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};
	["5fDNE"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};
	["5fEND"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};
	["5fDNW"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};
	["5fWND"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = 0
	};

	["5gSUE"] = {
		Part = TAIL[5].Base,
		VertexNumber = 0
	};
	["5gSUW"] = {
		Part = TAIL[5].Base,
		VertexNumber = 0
	};
	["5gSDE"] = {
		Part = TAIL[5].Base,
		VertexNumber = 0
	};
	["5gSDW"] = {
		Part = TAIL[5].Base,
		VertexNumber = 0
	};

	["6fUNE"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
	["6fENU"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
	["6fUNW"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
	["6fWNU"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
	["6fDNE"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
	["6fEND"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
	["6fDNW"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
	["6fWND"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = 0
	};
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

events.ENTITY_INIT:register(addVerticeOriginVectors, "FoxTailHandler")


local function applyVertexPairing(vertex_pairing)
	local vertex0 = VERTICES[vertex_pairing[0]]

	-- Last time I tried this, I set the gapfill vertices position to the raw Base part vertices,
	--  and that didn't work.
	-- So instead, lets try setting the gapfill vertex position to its Origin Position + the Delta between
	--  Base vertex's Origin Position and Current Position.
	-- 
	-- Yeah it's the same thing, but I assuming there's some scuff at play. 
	--  May it be Figura, Minecraft, and/or Java scuff.
	local pos0Delta = vertex0.originPos - vertex0.Part:getVertices(TEXTURE)[vertex0.VertexNumber]:getPos()
	for i = 1, #vertex_pairing do
		local vertexi = VERTICES[vertex_pairing[i]]

		local newPosi = vertexi.originPos + pos0Delta
		vertexi.Part:getVertices(TEXTURE)[vertexi.VertexNumber]:setPos(newPosi)
	end
end

events.RENDER:register(function (delta, context, matrix)
	for i = 1, #VERTEX_PAIRINGS do
		applyVertexPairing(VERTEX_PAIRINGS[i])
	end
end, "FoxTailHandler")