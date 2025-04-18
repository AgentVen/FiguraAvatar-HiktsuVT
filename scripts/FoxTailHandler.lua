---@class FoxTailClass #


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


local VERTICES = setmetatable({
	["ENU"] = 5,	["WNU"] = 11,	["UNE"] = 3,	["DNE"] = 14,
	["END"] = 8,	["WND"] = 12,	["UNW"] = 4,	["DNW"] = 13,
	["ESU"] = 6,	["WSU"] = 10,	["USE"] = 2,	["DSE"] = 15,
	["ESD"] = 7,	["WSD"] = 9,	["USW"] = 1,	["DSW"] = 16;
},{
	__call = function(t, vertexKey, ...)
		assert(type(vertexKey) == 'string', "Bad Argument #2; invalid type. (expected type(s): 'string', got type: '"..type(vertexKey)..".)")
		
		if type(...) ~= 'nil' then
			for i = 1, select("#", ...), 1 do
				local arg_i = select(i, ...)
				assert(type(arg_i) == 'string', "Bad Argument #"..i + 2 .."; invalid type. (expected type(s): 'string', got type: '"..type(arg_i)..".)")
				
				if arg_i:find("^[NSEWUD][NSEWUD]$") then
					local swapA,swapB = arg_i:match("([NSEWUD])([NSEWUD])")
					vertexKey = vertexKey:gsub(".", { [""..swapA..""] = ""..swapB.."", [""..swapB..""] = ""..swapA.."" })
				elseif arg_i:find("^[1-3][1-3][1-3]$") then
					local newVertexKey = ""
					for p in arg_i:gmatch("([1-3])") do
						p = tonumber(p)
						newVertexKey = newVertexKey..vertexKey:sub(p,p)
					end
					vertexKey = newVertexKey
				else
					error("Bad Argument #"..i + 2 .."; invalid/malformed operation.", 6)
				end
			end
		end
		
		return t[vertexKey]
	end		
})


---"Gap-crossing" method, solution #1: Set Pos to Get Pos.
--[[ CONCLUSION: Complete failure!
	Ok, so I figured out why it wasn't working. 

	It's because the positions of vertices on a Mesh are *realitive* to 
	their own *unique* 0,0,0 point, which is initally set to the 
	"Model Space"'s 0,0,0 point. 
	I say "initally set" because once at runtime the point's position in 
	the "Model Space" *becomes* realitive to the Mesh, meaning changes 
	to the Mesh's position and/or rotation would not change the 
	positions of the vertices.
	
	Now, I'm not calling to change this. In fact I understand why its done this way.
	However, some documentation on this quirk would've been nice. (Then again no
	iteration of the documentation on Vertices is anymore than a stub..)
	
	But now, I know what I need to do get this finally working!
	And it's the ton of math I was originally trying to advoid.
--]]

---"Gap-crossing" method, solution #2: Determine Pos from getting a point on the circumference of 2 circles.
local function getVertexGapfillPosByCrossing_DoubleCircle(bone, vertexKey, Theta, Phi)
	local nativeOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS")]:getPos()
	local siblingOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS", "EW")]:getPos().x
	local twinOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS", "321")]:getPos().y
	local cousinOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS", "321", "UD")]:getPos().y
		
	local r = vec(
		(nativeOriginPos.x - siblingOriginPos) / 2,
		(twinOriginPos - cousinOriginPos) / 2
	)
	
	local offsetOriginPos = vec(
		math.max(nativeOriginPos.x, siblingOriginPos) - math.abs(r.x),
		math.max(twinOriginPos, cousinOriginPos) - math.abs(r.y),
		nativeOriginPos.z
	)


	local newPos = offsetOriginPos + vec(
		r.x * math.cos(Theta),
		r.y * math.cos(Phi),
		r.x * -math.sin(Theta) + r.y * -math.sin(Phi)
	)

	if newPos.z <= nativeOriginPos.z then
		newPos = nativeOriginPos
	end

	--[[ 
	do -- DEBUG
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


		print("\"bone\" :",bone, "\"vertexKey\" :",vertexKey, "\"vertex_index\" :",VERTICES[vertexKey])
		print("\"Theta\" :",math.deg(Theta),Theta, "\"Phi\" :",math.deg(Phi),Phi)
		print("\"nativeOriginPos\" :",nativeOriginPos, "\"siblingOriginPos\" :",siblingOriginPos, "\"twinOriginPos\" :",twinOriginPos, "\"cousinOriginPos\" :",cousinOriginPos)
		print("\"r\" :",r)
		print("\"offsetOriginPos\" :",offsetOriginPos)
		print("\"newPos\" :",newPos)
	end
	--]]

	TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES[vertexKey]]:setPos(newPos)

	--return newPos --TODO: Work out UV
end
--[[ CONCLUSION: Partial success!
	Works when rotating just on the X or just the Y, not on both.
--]]

---"Gap-crossing" method, solution #3: Determine Pos from getting a point on the circumference of a sphere.
local function getVertexGapfillPosByCrossing_Sphere(bone, vertexKey, Theta, Phi)
	local nativeOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS")]:getPos()
	local siblingOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS", "EW")]:getPos().x
	local twinOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS", "321")]:getPos().y
	local cousinOriginPos = TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES(vertexKey, "NS", "321", "UD")]:getPos().y

	-- This won’t work if the sides are unequal.
	-- 
	-- That would require us to get a point on the circumference 
	-- of an Ellipsoid (3D ellipsis), this code is for getting 
	-- a point on the circumference of a Sphere.
	-- It *can* be adapted for such, if we could get `r.z`.
	-- But getting `r.z` is just the “Double-Z to One-Z” problem all over again.

	local r = vec(
		(nativeOriginPos.x - siblingOriginPos) / 2,
		(twinOriginPos - cousinOriginPos) / 2
 	)

	local offsetOriginPos = vec(
		math.max(nativeOriginPos.x, siblingOriginPos) - math.abs(r.x),
		math.max(twinOriginPos, cousinOriginPos) - math.abs(r.y),
		nativeOriginPos.z
	)


	local newPos = offsetOriginPos + vec(
		r.x * (((Theta ~= 0) and math.cos(Theta)) or Theta) * math.sin(Phi),
		r.y * (((Phi ~= 0) and math.cos(Phi)) or Phi),
		r.x * math.sin(Theta) * math.sin(Phi)
	)

	if newPos.z <= offsetOriginPos.z then
		newPos = offsetOriginPos
	end

	TAIL[bone].gapfill:getVertices(TEXTURE)[VERTICES[vertexKey]]:setPos(newPos)

	--return newPos --TODO: Work out UV
end
--[[ CONCLUSION: Completely failed!
	Just X or just Y rotation doesn't work, because of Zero-ing Out.
	And both X and Y rotation didn't work.
--]]

---"Gap-crossing" method, solution #4: Set Pos to Get Pos, adjusted to be Relative to Model Origin.
---@param modelPart ModelPart
---@param vertex_index number
---@return Vector3
local function getVertexPosRelativeToModelOrigin(modelPart, vertex_index)
	do -- Type checking & correction
		assert(type(modelPart) == 'ModelPart',
			"Bad argument #1; Invaild type! (expected type(s): 'ModelPart', got: '"..type(modelPart)..".)"
		)
		assert(modelPart:getType():lower() == "mesh",
			"Bad argument #1; Invaild type! (expected type(s): 'Mesh', got: '"..modelPart:getType()..".)"
		)
		local vertices = #modelPart:getVertices(TEXTURE)
		assert(vertices > 0,
			"Bad argument #1; Has no vertices for required texture!"
		)

		assert(type(vertex_index) == 'number',
			"Bad argument #2; Invaild type! (expected type(s): 'number', got: '"..type(vertex_index)..".)"
		)
		assert(vertex_index >= 1 and vertex_index <= vertices,
			"Bad argument #2; Out of range! (expected number from: 1, to: "..vertices..", got: "..vertex_index..".)"
		)
	end

	-- TODO-INVESTIGATE/TEST:
	-- According to the documentation, `:getTruePos()` should be exactly what we
	-- want for getting the right Position Vector3. Including `:getPot()` and `:getAnimPot()`.
	--
	-- However, this needs to be tested.
	local modelPartPos = modelPart:getTruePos()
	-- TODO-INVESTIGATE: Look into what the vertex's normal is actually is.
	local vertexPos = modelPart:getVertices(TEXTURE)[vertex_index]:getPos()

	-- TODO: Might need expansion
	local newVertexPos = modelPartPos + vertexPos

	return newVertexPos
end
--[[ CONCLUSION: Completely failed.
	Same result as the original idea.
--]]

---"Deform-filling" method: Adjusting the Z of the vertices of the Base parts of BoneA and BoneB to meat in the middle, via tangents.
local TAIL_0_VERTICES = setmetatable({
	["SED"] = 33, ["SEU"] = 34, ["SWU"] = 35, ["SWD"] = 36;
	["ESU"] = 19, ["ESD"] = 20;
	["WSD"] = 21, ["WSU"] = 22;
	["USE"] = 25, ["USW"] = 28;
	["DSE"] = 30, ["DSW"] = 31;
},{
	__call = function(t, vertexKey, ...)
		assert(type(vertexKey) == 'string', "Bad Argument #2; invalid type. (expected type(s): 'string', got type: '"..type(vertexKey)..".)")
		
		if type(...) ~= 'nil' then
			for i = 1, select("#", ...), 1 do
				local arg_i = select(i, ...)
				assert(type(arg_i) == 'string', "Bad Argument #"..i + 2 .."; invalid type. (expected type(s): 'string', got type: '"..type(arg_i)..".)")
				
				if arg_i:find("^[NSEWUD][NSEWUD]$") then
					local swapA,swapB = arg_i:match("([NSEWUD])([NSEWUD])")
					vertexKey = vertexKey:gsub(".", { [""..swapA..""] = ""..swapB.."", [""..swapB..""] = ""..swapA.."" })
				elseif arg_i:find("^[1-3][1-3][1-3]$") then
					local newVertexKey = ""
					for p in arg_i:gmatch("([1-3])") do
						p = tonumber(p)
						newVertexKey = newVertexKey..vertexKey:sub(p,p)
					end
					vertexKey = newVertexKey
				else
					error("Bad Argument #"..i + 2 .."; invalid/malformed operation.", 6)
				end
			end
		end
		
		return t[vertexKey]
	end	
})

local vertexOriginPoses = {}
local function getVertexGapfillPosByDeforming(bone, vertexKey, Theta)
	local nativeOriginPos = vertexOriginPoses[TAIL_0_VERTICES(vertexKey)] or TAIL[bone].Base:getVertices(TEXTURE)[TAIL_0_VERTICES(vertexKey)]:getPos()
	local siblingOriginPos = vertexOriginPoses[TAIL_0_VERTICES(vertexKey, "EW")] or TAIL[bone].Base:getVertices(TEXTURE)[TAIL_0_VERTICES(vertexKey, "EW")]:getPos()
	
	if not vertexOriginPoses[TAIL_0_VERTICES(vertexKey)] then
		vertexOriginPoses[TAIL_0_VERTICES(vertexKey)] = nativeOriginPos
	end
	if not vertexOriginPoses[TAIL_0_VERTICES(vertexKey, "EW")] then
		vertexOriginPoses[TAIL_0_VERTICES(vertexKey, "EW")] = siblingOriginPos
	end

	local r = (nativeOriginPos.x - siblingOriginPos.x) / 2

	local newPos = vec(
		nativeOriginPos.x, nativeOriginPos.y,
		nativeOriginPos.z - (math.tan(Theta / 2) * r)
	)

	TAIL[bone].Base:getVertices(TEXTURE)[TAIL_0_VERTICES[vertexKey]]:setPos(newPos)

	--return newPos --TODO: Work out UV
end
local function getVertexGapfillPosByDeforming_y(bone, vertexKey, Phi)
	local nativeOriginPos = vertexOriginPoses[TAIL_0_VERTICES(vertexKey)] or TAIL[bone].Base:getVertices(TEXTURE)[TAIL_0_VERTICES(vertexKey)]:getPos()
	local siblingOriginPos = vertexOriginPoses[TAIL_0_VERTICES(vertexKey, "UD")] or TAIL[bone].Base:getVertices(TEXTURE)[TAIL_0_VERTICES(vertexKey, "UD")]:getPos()
	
	if not vertexOriginPoses[TAIL_0_VERTICES(vertexKey)] then
		vertexOriginPoses[TAIL_0_VERTICES(vertexKey)] = nativeOriginPos
	end
	if not vertexOriginPoses[TAIL_0_VERTICES(vertexKey, "UD")] then
		vertexOriginPoses[TAIL_0_VERTICES(vertexKey, "UD")] = siblingOriginPos
	end

	local r = (nativeOriginPos.y - siblingOriginPos.y) / 2

	local newPos = vec(
		nativeOriginPos.x, nativeOriginPos.y,
		nativeOriginPos.z - (math.tan(Phi / 2) * r)
	)

	TAIL[bone].Base:getVertices(TEXTURE)[TAIL_0_VERTICES[vertexKey]]:setPos(newPos)

	--return newPos --TODO: Work out UV
end
--[[ CONCLUSION: So far, partial success.
--]]


events.RENDER:register(function (delta, context, matrix)
	
	do -- TEMP DEBUG
		--TAIL[0].Base:setOpacity(0.75)
		TAIL[1].Base:setOpacity(0.75)
		TAIL[2].Base:setOpacity(0.75)
		TAIL[3].Base:setOpacity(0.75)
		TAIL[4].Base:setOpacity(0.75)
		TAIL[5].Base:setOpacity(0.75)
		TAIL[6].Base:setOpacity(0.75)
	end--]]

--[[ TODO: Update this, or delete it
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
--]]

	for bone = 0, #TAIL, 1 do
		if bone < 3 then
			-- TODO-INVESTIGATE/TEST:
			-- According to the documentation, `:getTrueRot()` should be exactly what we
			-- want for getting the right Rotation Vector3. Including `:getRot()`, 
			-- `:getOffsetRot()`, and `:getAnimRot()`.
			--
			-- However, this needs to be tested.
			local Theta, Phi = TAIL[bone + 1]:getTrueRot():toRad():unpack()

			--[[
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "ESU", Theta, Phi)
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "ESD", Theta, Phi)
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "WSU", Theta, Phi)
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "WSD", Theta, Phi)
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "USE", Theta, Phi)
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "USW", Theta, Phi)
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "DSE", Theta, Phi)
			getVertexGapfillPosByCrossing_DoubleCircle(bone, "DSW", Theta, Phi)
			--]]



		elseif bone > 3 then
		end
	end
	
	-- [[
	TAIL[0].gapfill:setOpacity(0)
	local Theta, Phi = TAIL[1]:getTrueRot():toRad():unpack()
	getVertexGapfillPosByDeforming_y(0, "ESU", Phi)
	getVertexGapfillPosByDeforming_y(0, "ESD", Phi)
	getVertexGapfillPosByDeforming_y(0, "WSD", Phi)
	getVertexGapfillPosByDeforming_y(0, "WSU", Phi)
	getVertexGapfillPosByDeforming(0, "USE", Theta)
	getVertexGapfillPosByDeforming(0, "USW", Theta)
	getVertexGapfillPosByDeforming(0, "DSE", Theta)
	getVertexGapfillPosByDeforming(0, "DSW", Theta)
	--]]

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
local PART = TAIL[0].Base

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