BattleCommand_UTurn:
; uturn

	ldh a, [hBattleTurn]
	and a
	jp nz, .Enemy

; Need something to switch to
	call CheckAnyOtherAlivePartyMons
	ret z  ; nothing to do if there are no other Pokémon

	call UpdateBattleMonInParty

	; ld c, 20
	; call DelayFrames

; Transition into switchmon menu
	call LoadStandardMenuHeader
	farcall SetUpBattlePartyMenu

	farcall ForcePickSwitchMonInBattle

; Return to battle scene
	call ClearPalettes
	farcall _LoadBattleFontsHPBar
	call CloseWindow
	call ClearSprites
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	call SetPalettes

	ld hl, SwitchPlayerMon
	call CallBattleCore
	ld hl, SpikesDamage
	call CallBattleCore
	ld hl, HandlePlayerBattlecryAbility
	jp CallBattleCore

.Enemy:
; Wildmons don't have anything to switch to
	ld a, [wBattleMode]
	dec a ; WILDMON
	ret z

	call CheckAnyOtherAliveEnemyMons
	ret z

	call UpdateEnemyMonInParty

; Passed enemy PartyMon entrance
	ld a, [wOTPartyCount]
	ld b, a
	ld a, [wCurOTMon]
	ld c, a
; select a random enemy mon to switch to
.random_loop_trainer
	call BattleRandom
	and $7
	cp b
	jr nc, .random_loop_trainer
	cp c
	jr z, .random_loop_trainer
	push af
	push bc
	ld hl, wOTPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	pop bc
	pop de
	jr z, .random_loop_trainer
	ld a, d
	inc a
	ld [wEnemySwitchMonIndex], a
	callfar ForceEnemySwitch
	ld hl, SpikesDamage
	call CallBattleCore
	ld hl, HandleEnemyBattlecryAbility
	jp CallBattleCore
