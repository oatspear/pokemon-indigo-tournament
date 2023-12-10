AbilityDescriptions::
	; entries correspond to ability ids (see constants/ability_constants.asm)
		dw NoGuardDescription
		dw BattleArmorDescription
		dw MoldBreakerDescription
		dw ChlorophyllDescription
		dw SwiftSwimDescription
		dw SandRushDescription
		dw SlushRushDescription
		dw FlashFireDescription
		dw LightningRodDescription
		dw LevitateDescription


NoAbilityDescription:
	db "---@"

NoGuardDescription:
	db   "Accuracy checks"
	next "are skipped.@"

BattleArmorDescription:
	db   "Blocks critical"
	next "hits.@"

MoldBreakerDescription:
	db   "Negates defensive"
	next "abilities.@"

ChlorophyllDescription:
	db   "Doubles SPEED"
	next "in sunlight.@"

SwiftSwimDescription:
	db   "Doubles SPEED"
	next "in rain.@"

SandRushDescription:
	db   "Doubles SPEED in"
	next "a sandstorm.@"

SlushRushDescription:
	db   "Doubles SPEED in"
	next "a hail storm.@"

FlashFireDescription:
	db   "Powers up if hit"
	next "by FIRE.@"

LightningRodDescription:
	db   "Ups SP. ATK. if"
	next "hit by ELECTRIC.@"

LevitateDescription:
	db   "Immune to GROUND"
	next "moves.@"
