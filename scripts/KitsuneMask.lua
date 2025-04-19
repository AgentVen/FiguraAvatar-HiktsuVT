---@class KitsuneMaskClass #
---@field maskState number #


local MASK_FOX = models.models.mask_fox.root.Head

local MASK_FOX_OFFSET_POSITION = vec(-1, 2, 0)
local MASK_FOX_OFFSET_ROTATION = vec(21.444, 54.4363, 5.151)
local DANGLE_OFFSET_ROTATION = vec(-17.5486, 0.7625, -3.6039)
local DANGLE_RIGHT_ORIGIN_POSITION = vec(4.15, 24.075, -4.6)
local DANGLE_RIGHT_OFFSET_POSITION = vec(-6.4273, 3.575, -1.4928)
local DANGLE_RIGHT_OFFSET_ROTATION = vec(0, 0, 0) -- y-35
local DANGLE_LEFT_ORIGIN_POSITION = vec(-4.35, 24.075, -4.6)
local DANGLE_LEFT_OFFSET_POSITION = vec(-2.8586, 3.125, 5.4241)
local DANGLE_LEFT_OFFSET_ROTATION = vec(0, 0, 0) -- y-32.5


local MASK_STATE = 2	--todo)) Move this to some place where it can be more easly changed durring runtime.


--todo)) Hopefully this will make it so looking through the eye holes from the back of the mask is not obstructed.
MASK_FOX.mask_fox.sclera_left:setPrimaryRenderType("TRANSLUCENT_CULL")
MASK_FOX.mask_fox.sclera_right:setPrimaryRenderType("TRANSLUCENT_CULL")
MASK_FOX.mask_fox.pupil_left:setPrimaryRenderType("TRANSLUCENT_CULL")
MASK_FOX.mask_fox.pupil_right:setPrimaryRenderType("TRANSLUCENT_CULL")

-- Setup the emissives for the pupils.
MASK_FOX.mask_fox.pupil_left:setSecondaryRenderType("EMISSIVE")
MASK_FOX.mask_fox.pupil_right:setSecondaryRenderType("EMISSIVE")
MASK_FOX.mask_fox.pupil_right:setSecondaryRenderType("EMISSIVE")
-- I don't know why. I don't want to known why. I shouldn't have to wonder why.
-- 
-- But for whatever reason, the "CUSTOM" texture mode sometimes 
--  wants to be given the texture via its file path, while other 
--  times it wants to be given it via a Model that loads it??
--
-- In other words. If the script errors out because of a "invalid texture path"
-- switch out "textures.mask_fox_pupils_e" with "models.mask_fox.mask_fox_pupils_e" 
-- and vice-versa.
--MASK_FOX.mask_fox.pupil_left:setSecondaryTexture("CUSTOM", textures["models.mask_fox.mask_fox_pupils_e"])
MASK_FOX.mask_fox.pupil_left:setSecondaryTexture("CUSTOM", textures["textures.mask_fox_pupils_e"])
--MASK_FOX.mask_fox.pupil_right:setSecondaryTexture("CUSTOM", textures["models.mask_fox.mask_fox_pupils_e"])
MASK_FOX.mask_fox.pupil_right:setSecondaryTexture("CUSTOM", textures["textures.mask_fox_pupils_e"])

-- Hide all parts initally
MASK_FOX.strap:setVisible(false)
MASK_FOX.strap_offtotheside:setVisible(false)
MASK_FOX.mask_fox:setVisible(false)


---@return Vector3
local function dangleRightRotationPhysicsCorrection(mask_state)
	local headPitch = player:getRot().x

	-- Isolating the x, so that we can use "If" statments
	-- 
	-- We clamp the x so that is looks like it gets cought on soild objects.
	local x = 0
	if mask_state == 1 then
		x = math.clamp(headPitch, 0, 90)
	elseif mask_state == 2 then
		x = math.clamp(headPitch, -12, 90)
	end

	local newRot = vec(x, 0, 0)

	-- Seperate adjust ment for the end part of the dangle, when the rest gets cought on a soild object, but it can keep going.
	if (mask_state == 1) and headPitch < 0 then
		MASK_FOX.mask_dangle_right.dangle_right:setRot(
			headPitch,
			0, 0
		)
	elseif mask_state == 2 then
		if headPitch <= -12 then
			MASK_FOX.mask_dangle_right.dangle_right:setRot(
				math.clamp(headPitch, -10, 90),
				0, 0
			)
		else
			MASK_FOX.mask_dangle_right.dangle_right:setRot(0, 0, 0)
		end
	end

	return newRot
end

---@return Vector3
local function dangleLeftRotationPhysicsCorrection(mask_state)
	local headPitch = player:getRot().x

	-- Isolating the x, so that we can use "If" statments
	-- 
	-- We clamp the x so that is looks like it gets cought on soild objects.
	local x = 0
	if mask_state == 1 then
		x = math.clamp(headPitch, 0, 90)
	elseif mask_state == 2 then
		x = math.clamp(headPitch, -90, 11)
	end

	local newRot = vec(x, 0, 0)

	-- Seperate adjust ment for the end part of the dangle, when the rest gets cought on a soild object, but it can keep going.
	if (mask_state == 1) and headPitch < 0 then
		MASK_FOX.mask_dangle_left.dangle_left:setRot(
			headPitch,
			0, 0
		)
	elseif mask_state == 2 then
		if headPitch >= 11 then
			MASK_FOX.mask_dangle_left.dangle_left:setRot(
				headPitch - newRot.x,
				0, 0
			)
		else
			MASK_FOX.mask_dangle_right.dangle_right:setRot(0, 0, 0)
		end
	end

	return newRot
end

-- State change handling on every RENDER event
events.RENDER:register(function(delta, renderContext, matrix)

	--print(MASK_FOX.mask_dangle_right:getPos())
	--print(MASK_FOX.mask_dangle_left:getPos())

	-- Removed
	if MASK_STATE == 0 then
		MASK_FOX.strap:setVisible(false)
		MASK_FOX.strap_offtotheside:setVisible(false)
		MASK_FOX.mask_fox:setVisible(false)
	-- Covers face
	elseif MASK_STATE == 1 then
		MASK_FOX.mask_fox:setPos(0, 0, 0)
		MASK_FOX.mask_fox:setRot(0, 0, 0)
		MASK_FOX.mask_dangle_right:setPos(0, 0, 0)
		MASK_FOX.mask_dangle_right:setRot(dangleRightRotationPhysicsCorrection(MASK_STATE))
		MASK_FOX.mask_dangle_right:setPos(0, 0, 0)
		MASK_FOX.mask_dangle_left:setRot(dangleLeftRotationPhysicsCorrection(MASK_STATE))
		MASK_FOX.strap:setVisible(true)
		MASK_FOX.strap_offtotheside:setVisible(false)
		MASK_FOX.mask_fox:setVisible(true)
	-- Off to the side
	elseif MASK_STATE == 2 then
		MASK_FOX.mask_fox:setPos(MASK_FOX_OFFSET_POSITION)
		MASK_FOX.mask_fox:setRot(MASK_FOX_OFFSET_ROTATION)
		MASK_FOX.mask_dangle_right:setPos(DANGLE_RIGHT_OFFSET_POSITION)
		MASK_FOX.mask_dangle_right:setRot(DANGLE_RIGHT_OFFSET_ROTATION + dangleRightRotationPhysicsCorrection(MASK_STATE))
		MASK_FOX.mask_dangle_left:setPos(DANGLE_LEFT_OFFSET_POSITION)
		MASK_FOX.mask_dangle_left:setRot(DANGLE_LEFT_OFFSET_ROTATION + dangleLeftRotationPhysicsCorrection(MASK_STATE))
		MASK_FOX.strap:setVisible(false)
		MASK_FOX.strap_offtotheside:setVisible(true)
		MASK_FOX.mask_fox:setVisible(true)
	end

end, "KitsuneMask-RENDER")