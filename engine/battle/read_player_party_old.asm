ReadPlayerParty:
    ld hl, wPartyCount  ; hl = wPartyCount (address)
	xor a               ; a = 0
	ld [hli], a         ; *hl = 0; hl++ (hl = wPartySpecies)
	dec a               ; a = -1
	ld [hl], a          ; *hl = -1 (end of list)

	ld hl, wPartyMons
	ld bc, wPartyMonsEnd - wPartyMons
	xor a
	call ByteFill ; fills bc bytes (all party structs) with a (0)

	ld a, [wTPTPlayerData]      ; Trainer Class constant
	and TRAINER_CLASS_BIT_MASK  ; dismiss flags

	dec a ; zero-based index
	ld c, a
	ld b, 0
	ld hl, PlayerTrainerGroups ; go to table of addresses
	add hl, bc
	add hl, bc  ; add twice to skip words, not bytes
	ld a, [hli] ; save the low byte of the address
	ld h, [hl]  ; high part of the address remains
	ld l, a     ; set the low part of the address to the concrete trainer

.skip_name
	ld a, [hli]
	cp "@"
	jr nz, .skip_name

	ld d, h
	ld e, l
	ld hl, PlayerTrainerType2
	ld bc, .done
	push bc
	jp hl

.done
	ret

PlayerTrainerGroups:
; entries correspond to trainer classes (see constants/trainer_constants.asm)
	dw PlayerFalknerGroup

PlayerFalknerGroup:
	; FALKNER (1)
	db "FALKNER@"
	db 50, PIDGEOT,  FLY, MIRROR_MOVE, AGILITY, QUICK_ATTACK
	db 50, FEAROW,   DRILL_PECK, AGILITY, DOUBLE_EDGE, PURSUIT
	db 50, NOCTOWL,  HYPNOSIS, REFLECT, NIGHT_SHADE, REST
	db 50, MURKROW,  DRILL_PECK, FAINT_ATTACK, PURSUIT, NIGHT_SHADE
	db 50, SKARMORY, WHIRLWIND, DRILL_PECK, REST, CURSE
	db 50, PIDGEOT,  RETURN, WING_ATTACK, STEEL_WING, MIRROR_MOVE
	db 50, FEAROW,   REST, SLEEP_TALK, DOUBLE_EDGE, DRILL_PECK
	db 50, DODRIO,   DOUBLE_EDGE, DRILL_PECK, REST, SLEEP_TALK
	db -1 ; end

PlayerTrainerType2:
; level, species, moves
	ld h, d
	ld l, e
.loop
; return if the end of the list is reached
	ld a, [hl]
	cp $ff
	ret z

; if the party is already full, send one to the PC
	push hl ; save hl for later
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nz, .read_into_party
	call _DepositLastPokemon

.read_into_party
	pop hl
	ld a, [hli]
	ld [wCurPartyLevel], a
	ld a, [hli]
	ld [wCurPartySpecies], a
	ld a, PARTYMON
	ld [wMonType], a
	;ld a, TRAINER_BATTLE
	;ld [wBattleMode], a

; TryAddMonToParty requires
; [x] wPartyCount
; [x] wMonType (PARTYMON)
; [x] wCurPartySpecies
; [?] wPartyMonOT
; [?] wPlayerName
; [ ] wBattleMode
; [x] wCurPartyLevel
	push hl
	predef TryAddMonToParty
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

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
	ld hl, wPartyMon1Species
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
	jr .loop


_DepositLastPokemon:
; send one to the PC
; copied from Bill's PC DepositPokemon
	ld a, PARTY_LENGTH - 1
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld a, [wCurPartyMon]
	call GetNick
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
; assert not box full
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
    ret
