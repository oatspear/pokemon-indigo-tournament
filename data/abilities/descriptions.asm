AbilityDescriptions::
	; entries correspond to ability ids (see constants/ability_constants.asm)
		dw NoGuardDescription
		dw BattleArmorDescription


NoAbilityDescription:
	db "---@"

NoGuardDescription:
	db   "Accuracy checks"
	next "are skipped.@"

BattleArmorDescription:
	db   "Blocks critical"
	next "hits.@"
