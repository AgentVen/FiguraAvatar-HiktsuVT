events.ENTITY_INIT:register(function ()
	KitsuneMask = require("scripts/KitsuneMask")
	FoxTailHandler = require("scripts/FoxTailHandler")

	for _, vanillaModel in ipairs({vanilla_model.PLAYER}) do
		vanillaModel:setVisible(false)
	end
end, "main")