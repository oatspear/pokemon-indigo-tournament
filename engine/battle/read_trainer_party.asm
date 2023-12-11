ReadPlayerParty:
	ld hl, wPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a  ; wPartySpecies[0] = -1

	ld hl, wPartyMons
	ld bc, wPartyMonsEnd - wPartyMons
	xor a
	call ByteFill

	ld a, [wOtherTrainerClass]

	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop
	ld a, [hli]
	cp -1
	jr nz, .loop
	jr .skip_trainer
.got_trainer

.skip_name
	ld a, [hli]
	cp "@"
	jr nz, .skip_name

	ld d, h
	ld e, l
	; jr PlayerTrainerType4
	; fallthrough

PlayerTrainerType4:
; species, item, ability, EVs, moves
	ld h, d
	ld l, e
	ld a, TPT_MON_LEVEL         ; hard-coded level
	ld [wCurPartyLevel], a
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartySpecies], a

	ld a, PARTYMON
	ld [wMonType], a

; prepare item
	push hl
	predef TryAddMonToParty
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read item
	ld a, [hli]
	ld [de], a

; prepare ability
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Ability
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read ability
	ld a, [hli]
	ld [de], a

; prepare EVs
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1EVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read EVs
	call _ReadEVs

; prepare moves
	push hl
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read moves
	ld b, NUM_MOVES
.copy_moves
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl

; Custom EVs affect stats, so recalculate them after TryAddMonToParty
	push hl

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1MaxHP
	call GetPartyLocation
	ld d, h
	ld e, l

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1EVs - 1
	call GetPartyLocation

; recalculate stats
	ld b, TRUE
	push de
	predef CalcMonStats
	pop hl

; copy max HP to current HP
	inc hl
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld [hl], c
	dec hl
	ld [hl], b

	pop hl
	jp .loop


_ReadEVs:
; TODO check that only 2 fields are set
	ld a, [hli]
	ld b, a
	ld a, MAX_EV
	bit HP_EV_BIT, b
	jr z, .atk_ev
	ld [de], a
.atk_ev
	inc de
	bit ATK_EV_BIT, b
	jr z, .def_ev
	ld [de], a
.def_ev
	inc de
	bit DEF_EV_BIT, b
	jr z, .spd_ev
	ld [de], a
.spd_ev
	inc de
	bit SPD_EV_BIT, b
	jr z, .sp_atk_ev
	ld [de], a
.sp_atk_ev
	inc de
	bit SP_ATK_EV_BIT, b
	jr z, .sp_def_ev
	ld [de], a
.sp_def_ev
	inc de
	bit SP_DEF_EV_BIT, b
	ret z
	ld [de], a
	ret


ReadTrainerParty:
	ld hl, wOTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, wOTPartyMons
	ld bc, wOTPartyMonsEnd - wOTPartyMons
	xor a
	call ByteFill

	ld a, [wOtherTrainerClass]

	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
.skip_trainer
	dec b
	jr z, .got_trainer
.loop
	ld a, [hli]
	cp -1
	jr nz, .loop
	jr .skip_trainer
.got_trainer

.skip_name
	ld a, [hli]
	cp "@"
	jr nz, .skip_name

	ld d, h
	ld e, l
	; ld hl, TrainerType4
	; ld bc, .done
	; push bc
	; jp hl
	call TrainerType4

.done
	jp ComputeTrainerReward


TrainerType4:
; species, item, ability, EVs, moves
	ld h, d
	ld l, e
	ld a, TPT_MON_LEVEL         ; hard-coded level
	ld [wCurPartyLevel], a
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartySpecies], a

	ld a, OTPARTYMON
	ld [wMonType], a

; prepare item
	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read item
	ld a, [hli]
	ld [de], a

; prepare ability
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Ability
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read ability
	ld a, [hli]
	ld [de], a

; prepare EVs
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1EVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read EVs
	call _ReadEVs

; prepare moves
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

; read moves
	ld b, NUM_MOVES
.copy_moves
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl

; Custom EVs affect stats, so recalculate them after TryAddMonToParty
	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1MaxHP
	call GetPartyLocation
	ld d, h
	ld e, l

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1EVs - 1
	call GetPartyLocation

; recalculate stats
	ld b, TRUE
	push de
	predef CalcMonStats
	pop hl

; copy max HP to current HP
	inc hl
	ld c, [hl]
	dec hl
	ld b, [hl]
	dec hl
	ld [hl], c
	dec hl
	ld [hl], b

	pop hl

	jp .loop

ComputeTrainerReward:
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a ; hMultiplicand + 0
	ld [hli], a ; hMultiplicand + 1
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a ; hMultiplicand + 2
	ld a, [wCurPartyLevel]
	ld [hl], a ; hMultiplier
	call Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	ret

Battle_GetTrainerName::
	ld a, [wInBattleTowerBattle]
	bit 0, a
	ld hl, wOTPlayerName
	jp nz, CopyTrainerName

	ld a, [wOtherTrainerID]
	ld b, a
	ld a, [wOtherTrainerClass]
	ld c, a

GetTrainerName::
	ld a, c
	cp CAL
	jr nz, .not_cal2

	ld a, BANK(sMysteryGiftTrainerHouseFlag)
	call OpenSRAM
	ld a, [sMysteryGiftTrainerHouseFlag]
	and a
	call CloseSRAM
	jr z, .not_cal2

	ld a, BANK(sMysteryGiftPartnerName)
	call OpenSRAM
	ld hl, sMysteryGiftPartnerName
	call CopyTrainerName
	jp CloseSRAM

.not_cal2
	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc

.loop
	dec b
	jr z, CopyTrainerName

.skip
	ld a, [hli]
	cp $ff
	jr nz, .skip
	jr .loop

CopyTrainerName:
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	call CopyBytes
	pop de
	ret

CopyTrainerNameToDE:
	push de
	ld a, [wOtherTrainerID]
	ld b, a
	ld a, [wOtherTrainerClass]
	ld c, a

	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc

.loop
	dec b
	jr z, .copy

.skip
	ld a, [hli]
	cp $ff
	jr nz, .skip
	jr .loop

.copy
	ld bc, NAME_LENGTH
	; `de` should be set before the call
	call CopyBytes
	pop de
	ret

INCLUDE "data/trainers/parties.asm"
