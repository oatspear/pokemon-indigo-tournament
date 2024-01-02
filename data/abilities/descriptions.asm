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
		dw SapSipperDescription
		dw WaterAbsorbDescription
		dw VoltAbsorbDescription
		dw RainDishDescription
		dw SturdyDescription
		dw RockHeadDescription
		dw DrySkinDescription
		dw ThickFatDescription
		dw DroughtDescription
		dw DrizzleDescription
		dw SandStreamDescription
		dw SnowWarningDescription


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
	db   "Ups SP. ATK if"
	next "hit by ELECTRIC.@"

SapSipperDescription:
	db   "Ups ATTACK if"
	next "hit by GRASS.@"

LevitateDescription:
	db   "Immune to GROUND"
	next "moves.@"

WaterAbsorbDescription:
	db   "Heals if hit"
	next "by WATER.@"

VoltAbsorbDescription:
	db   "Heals if hit"
	next "by ELECTRIC.@"

RainDishDescription:
	db   "Heals during"
	next "heavy rain.@"

SturdyDescription:
	db   "Negates one-hit"
	next "KO attacks.@"

RockHeadDescription:
	db   "Prevents recoil"
	next "damage.@"

DrySkinDescription:
	db   "Heals with WATER."
	next "Hurts with FIRE.@"

ThickFatDescription:
	db   "Heat and cold"
	next "protection.@"

DroughtDescription:
	db   "Summons sunlight"
	next "in battle.@"

DrizzleDescription:
	db   "Summons rain"
	next "in battle.@"

SandStreamDescription:
	db   "Summons a"
	next "sandstorm.@"

SnowWarningDescription:
	db   "Summons hail"
	next "in battle.@"
