AbilityDescriptions::
	; entries correspond to ability ids (see constants/ability_constants.asm)
		dw NoGuardDescription


NoAbilityDescription:
	db "---@"

NoGuardDescription:
	db   "Accuracy checks"
	next "are skipped.@"
