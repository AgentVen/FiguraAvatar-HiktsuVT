---@class KisuneMaskClass #
---@field maskState number #


local MASK_FOX = models.models.mask_fox.root.Head

local OFFSET_POSITION = vec(-1, 2, 0)
local OFFSET_ROTATION = vec(21.444, 54.4363, 5.151)

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


-- State change handling on every RENDER event
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
end, "KitsuneMask")