; ability ids
; indexes for:
; - AbilityNames (see data/abilities/names.asm)
; - AbilityDescriptions (see data/abilities/descriptions.asm)
; - BattleAnimations (see data/abilities/animations.asm)
	const_def
	const NO_MOVE      ; 00
	const NO_GUARD     ; 01
	const BATTLE_ARMOR ; 02
NUM_ABILITIES EQU const_value - 1
