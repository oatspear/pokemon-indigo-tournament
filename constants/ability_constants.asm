; ability ids
; indexes for:
; - AbilityNames (see data/abilities/names.asm)
; - AbilityDescriptions (see data/abilities/descriptions.asm)
; - BattleAnimations (see data/abilities/animations.asm)
	const_def
	const NO_MOVE       ; 00
	const NO_GUARD      ; 01
	const BATTLE_ARMOR  ; 02
	const MOLD_BREAKER  ; 03
	const CHLOROPHYLL   ; 04
	const SWIFT_SWIM    ; 05
	const SAND_RUSH     ; 06
	const SLUSH_RUSH    ; 07
	const FLASH_FIRE    ; 08
	const LIGHTNING_ROD ; 09
	const LEVITATE      ; 0a
	const SAP_SIPPER    ; 0b
NUM_ABILITIES EQU const_value - 1
