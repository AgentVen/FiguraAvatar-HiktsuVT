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
	-- KEY
	-- #...  tail bone number (0: root - 6: tip)
	-- .#..  part idenification (g: gapfill part, B: base part(s))
	-- ..#.  vertex face position number ( 1 -> 2 \/ 3 -> 4)
	-- ...#  side of part (a: closer to main body, b: farther from main body)

	["0g1b"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = vec(0, 0)
	};
	["0g2b"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = vec(0, 0)
	};
	["0g3b"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = vec(0, 0)
	};
	["0g4b"] = {
		Part = TAIL[0].gapfill,
		VertexNumber = vec(0, 0)
	};

	["1B1a"] = {
		Part = TAIL[1].cube,
		VertexNumber = 0
	};
	["1B2a"] = {
		Part = TAIL[1].cube,
		VertexNumber = 0
	};
	["1B3a"] = {
		Part = TAIL[1].cube,
		VertexNumber = 0
	};
	["1B4a"] = {
		Part = TAIL[1].cube,
		VertexNumber = 0
	};

	["1g1b"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = vec(0, 0)
	};
	["1g2b"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = vec(0, 0)
	};
	["1g3b"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = vec(0, 0)
	};
	["1g4b"] = {
		Part = TAIL[1].gapfill,
		VertexNumber = vec(0, 0)
	};

	["2B1a"] = {
		Part = TAIL[2].cube,
		VertexNumber = 0
	};
	["2B2a"] = {
		Part = TAIL[2].cube,
		VertexNumber = 0
	};
	["2B3a"] = {
		Part = TAIL[2].cube,
		VertexNumber = 0
	};
	["2B4a"] = {
		Part = TAIL[2].cube,
		VertexNumber = 0
	};

	["2g1b"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = vec(0, 0)
	};
	["2g2b"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = vec(0, 0)
	};
	["2g3b"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = vec(0, 0)
	};
	["2g4b"] = {
		Part = TAIL[2].gapfill,
		VertexNumber = vec(0, 0)
	};

	["3B1a"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};
	["3B2a"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};
	["3B3a"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};
	["3B4a"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};
	
	["3B1b"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};
	["3B2b"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};
	["3B3b"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};
	["3B4b"] = {
		Part = TAIL[3].cube,
		VertexNumber = 0
	};

	["4B1b"] = {
		Part = TAIL[4].cube,
		VertexNumber = 0
	};
	["4B2b"] = {
		Part = TAIL[4].cube,
		VertexNumber = 0
	};
	["4B3b"] = {
		Part = TAIL[4].cube,
		VertexNumber = 0
	};
	["4B4b"] = {
		Part = TAIL[4].cube,
		VertexNumber = 0
	};

	["4g1a"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = vec(0, 0)
	};
	["4g2a"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = vec(0, 0)
	};
	["4g3a"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = vec(0, 0)
	};
	["4g4a"] = {
		Part = TAIL[4].gapfill,
		VertexNumber = vec(0, 0)
	};

	["5B1b"] = {
		Part = TAIL[5].cube,
		VertexNumber = 0
	};
	["5B2b"] = {
		Part = TAIL[5].cube,
		VertexNumber = 0
	};
	["5B3b"] = {
		Part = TAIL[5].cube,
		VertexNumber = 0
	};
	["5B4b"] = {
		Part = TAIL[5].cube,
		VertexNumber = 0
	};

	["5g1a"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = vec(0, 0)
	};
	["5g2a"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = vec(0, 0)
	};
	["5g3a"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = vec(0, 0)
	};
	["5g4a"] = {
		Part = TAIL[5].gapfill,
		VertexNumber = vec(0, 0)
	};

	["6g1a"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = vec(0, 0)
	};
	["6g2a"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = vec(0, 0)
	};
	["6g3a"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = vec(0, 0)
	};
	["6g4a"] = {
		Part = TAIL[6].gapfill,
		VertexNumber = vec(0, 0)
	};
}

local VERTEX_PAIRINGS = {
	{ [0] = "1B1a", [1] = "0g1b" },
	{ [0] = "1B2a", [1] = "0g2b" },
	{ [0] = "1B3a", [1] = "0g3b" },
	{ [0] = "1B4a", [1] = "0g4b" }
	;
	{ [0] = "2B1a", [1] = "1g1b" },
	{ [0] = "2B2a", [1] = "1g2b" },
	{ [0] = "2B3a", [1] = "1g3b" },
	{ [0] = "2B4a", [1] = "1g4b" }
	;
	{ [0] = "3B1a", [1] = "2g1b" },
	{ [0] = "3B2a", [1] = "2g2b" },
	{ [0] = "3B3a", [1] = "2g3b" },
	{ [0] = "3B4a", [1] = "2g4b" }
	;
	{ [0] = "3B1b", [1] = "4g1a" },
	{ [0] = "3B2b", [1] = "4g2a" },
	{ [0] = "3B3b", [1] = "4g3a" },
	{ [0] = "3B4b", [1] = "4g4a" }
	;
	{ [0] = "4B1b", [1] = "5g1a" },
	{ [0] = "4B2b", [1] = "5g2a" },
	{ [0] = "4B3b", [1] = "5g3a" },
	{ [0] = "4B4b", [1] = "5g4a" }
	;
	{ [0] = "5B1b", [1] = "6g1a" },
	{ [0] = "5B2b", [1] = "6g2a" },
	{ [0] = "5B3b", [1] = "6g3a" },
	{ [0] = "5B4b", [1] = "6g4a" }
}


local function onEntityInitalization()

	-- Add origin pos, uv, and normal vectors to vertices defined in VERTICES table.
	for k,v in pairs(VERTICES) do
		local vertexNumber = v.VertexNumber.x or v.VertexNumber

		v.originPos = v.Part:getVertices(TEXTURE)[vertexNumber]:getPos()
		v.originUV = v.Part:getVertices(TEXTURE)[vertexNumber]:getUV()
		v.originNormal = v.Part:getVertices(TEXTURE)[vertexNumber]:getNormal()

		-- If working with a double vertex, make sure the x and y vertexes have matching vectors.
		-- If not throw the corresponding error
		if type(v.VertexNumber) == 'Vector2' then
			if v.Part:getVertices(TEXTURE)[v.VertexNumber.y]:getPos() ~= v.originPos then
				error("Double Vertex \""..k.."\" does not have matching Pos vectors. (x: "..v.originPos:unpack().."  y: "..v.Part:getVertices(TEXTURE)[v.VertexNumber.y]:getPos():unpack()..".)", 6)
			end
			if v.Part:getVertices(TEXTURE)[v.VertexNumber.y]:getUV() ~= v.originUV then
				error("Double Vertex \""..k.."\" does not have matching UV vectors. (x: "..v.originUV:unpack()..", y: "..v.Part:getVertices(TEXTURE)[v.VertexNumber.y]:getUV():unpack()..".)", 6)
			end
			if v.Part:getVertices(TEXTURE)[v.VertexNumber.y]:getNormal() ~= v.originNormal then
				error("Double Vertex \""..k.."\" does not have matching Normal vectors. (x: "..v.originNormal:unpack()..", y: "..v.Part:getVertices(TEXTURE)[v.VertexNumber.y]:getNormal():unpack()..".)", 6)
			end
		end
	end

end

events.ENTITY_INIT:register(onEntityInitalization, "FoxTailHandler_onEntityInitalization")


local function applyVertexPairing(vertex_pairing)
	local vertex0 = VERTICES[vertex_pairing[0]]
	if type(vertex0.VertexNumber) == 'Vector2' then error("Vertex 0 in a Vertex Pairing cannot have a double vertex number.", 6) end

	local pos0Delta = vertex0.originPos - vertex0.Part:getVertices(TEXTURE)[vertex0.VertexNumber]:getPos()
	for i = 1, #vertex_pairing do
		local vertexi = VERTICES[vertex_pairing[i]]

		local newPosi = vertexi.Part:getVertices(TEXTURE)[vertexi.VertexNumber.x or vertexi.VertexNumber]:getPos() + pos0Delta
		if type(vertexi.VertexNumber) == 'Vector2' then
			vertexi.Part:getVertices(TEXTURE)[vertexi.VertexNumber.x]:setPos(newPosi)
			vertexi.Part:getVertices(TEXTURE)[vertexi.VertexNumber.y]:setPos(newPosi)
		else
			vertexi.Part:getVertices(TEXTURE)[vertexi.VertexNumber]:setPos(newPosi)
		end
	end
end

events.RENDER:register(function (delta, context, matrix)
	for i = 1, #VERTEX_PAIRINGS do
		applyVertexPairing(VERTEX_PAIRINGS[i])
	end
end, "FoxTailHandler")