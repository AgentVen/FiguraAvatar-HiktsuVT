events.ENTITY_INIT:register(function ()
	KitsuneMask = require("scripts/KitsuneMask")
	FoxTailGapfill = require("scripts/FoxTailGapfill")

	for _, vanillaModel in ipairs({vanilla_model.PLAYER}) do
		vanillaModel:setVisible(false)
	end
end)