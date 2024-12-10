---@class KisuneMaskClass #
---@field maskState number #


local MASK_FOX = models.models.mask_fox.root.Head

local OFFSET_POSITION = vec(-1, 2, 0)
local OFFSET_ROTATION = vec(21.444, 54.4363, 5.151)

local MASK_STATE = 2	--TODO: Move this to some place where it can be more easly changed durring runtime.


--Hopefully this will make it so looking through the eye holes from the back of the mask is not obstructed.
MASK_FOX.mask_fox.sclera_left:setPrimaryRenderType("TRANSLUCENT_CULL")
MASK_FOX.mask_fox.sclera_right:setPrimaryRenderType("TRANSLUCENT_CULL")
MASK_FOX.mask_fox.pupil_left:setPrimaryRenderType("TRANSLUCENT_CULL")
MASK_FOX.mask_fox.pupil_right:setPrimaryRenderType("TRANSLUCENT_CULL")
-- Setup the emissives for the pupils.
MASK_FOX.mask_fox.pupil_left:setSecondaryRenderType("EMISSIVE")
MASK_FOX.mask_fox.pupil_right:setSecondaryRenderType("EMISSIVE")
MASK_FOX.mask_fox.pupil_left:setSecondaryTexture("CUSTOM", textures["models.mask_fox.mask_fox_pupils_e"])
MASK_FOX.mask_fox.pupil_right:setSecondaryTexture("CUSTOM", textures["models.mask_fox.mask_fox_pupils_e"])

--Hide all parts, so we can pick and choose better.
MASK_FOX.strap:setVisible(false)
MASK_FOX.strap_offtotheside:setVisible(false)
MASK_FOX.mask_fox:setVisible(false)

--Rendering & State handling
events.RENDER:register(function()
	-- Removed
	if MASK_STATE == 0 then
		MASK_FOX.strap:setVisible(false)
		MASK_FOX.strap_offtotheside:setVisible(false)
		MASK_FOX.mask_fox:setVisible(false)
	-- Covers face
	elseif MASK_STATE == 1 then
		MASK_FOX.mask_fox:setOffsetRot(0,0,0)
		MASK_FOX.mask_fox:setPos(0,0,0)
		MASK_FOX.strap:setVisible(true)
		MASK_FOX.strap_offtotheside:setVisible(false)
		MASK_FOX.mask_fox:setVisible(true)
	-- Off to the side
	elseif MASK_STATE == 2 then
		MASK_FOX.mask_fox:setOffsetRot(OFFSET_ROTATION)
		MASK_FOX.mask_fox:setPos(OFFSET_POSITION)
		MASK_FOX.strap:setVisible(false)
		MASK_FOX.strap_offtotheside:setVisible(true)
		MASK_FOX.mask_fox:setVisible(true)
	end
end)