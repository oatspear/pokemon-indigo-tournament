; Double elimination tournament logic
;   8 JOHTO_GYM_LEADER classes [1-8]
;   8 KANTO_GYM_LEADER classes [9-16]
;   8 ELITE_TRAINER classes [17-24]

INCLUDE "data/events/tournament_data.asm"
INCLUDE "data/trainers/sprites.asm"


TPTLoadNextMatch:
    ld a, [wTPTNextMatch]
    ld l, a
    ld a, [wTPTNextMatch + 1]
    ld h, a
    ld a, [hl]              ; offset to skip from wTPTBrackets
    ld b, 0
    ld c, a
    ld hl, wTPTBrackets
    add hl, bc              ; hl now points to the next match

    ld a, [hli]             ; fetch the first trainer
    ld [wTPTTrainer1], a    ; this byte is [1][2][5]
                            ; 1 bit leftover/flag
                            ; 2 bits trainer id [0,3]
                            ; 5 bits trainer class [1, 24]
    and TRAINER_CLASS_BIT_MASK
    ld c, a
    ld b, SPRITE_TOURNAMENT_TRAINER1 - SPRITE_VARS
    push hl                 ; `hl` is affected by the functions below
    call _LoadVariableClassSprite
    ld hl, wTPTTrainer1
    call _SetOTClassAndID
    ld de, wRedsName
    farcall CopyTrainerNameToDE
    pop hl

    ld a, [hl]              ; fetch the second trainer
    ld [wTPTTrainer2], a
    and TRAINER_CLASS_BIT_MASK
    ld c, a
    ld b, SPRITE_TOURNAMENT_TRAINER2 - SPRITE_VARS
    call _LoadVariableClassSprite
    ld hl, wTPTTrainer2
    call _SetOTClassAndID
    ld de, wGreensName
    farcall CopyTrainerNameToDE
    ret


TPTReadTrainerPartiesPlayer1:
    ld a, TPT_BATTLE_SCRIPT_FLAGS
    ld [wBattleScriptFlags], a
    ld hl, wTPTTrainer1         ; player plays with the first party
    call _SetOTClassAndID
    farcall ReadPlayerParty
    ld hl, wTPTTrainer2         ; opponent plays with the second party
    call _SetOTClassAndID
    farcall ReadTrainerParty

    ld a, TPT_PLAYER_TRAINER1_FLAG
    ld [wTPTPlayerData], a
    ret

TPTReadTrainerPartiesPlayer2:
    ld a, TPT_BATTLE_SCRIPT_FLAGS
    ld [wBattleScriptFlags], a 
    ld hl, wTPTTrainer2         ; player plays with the second party
    call _SetOTClassAndID
    farcall ReadPlayerParty
    ld hl, wTPTTrainer1         ; opponent plays with the first party
    call _SetOTClassAndID
    farcall ReadTrainerParty

    xor a
    ld [wTPTPlayerData], a
    ret


; TPT battle in which the player participates
TPTPlayerBattle:
    call BufferScreen
    predef StartBattle

    ld a, [wBattleResult]
    and $ff ^ BATTLERESULT_BITMASK
    ld [wScriptVar], a
    cp LOSE
    jr nz, .player_won
; else: player lost
    ld a, [wTPTPlayerData]
    and TPT_PLAYER_TRAINER1_FLAG
    ret z   ; player lost and is second, both are in place
    call _SwapTournamentTrainers
    ret

.player_won
    ld a, [wTPTPlayerData]
    and TPT_PLAYER_TRAINER1_FLAG
    ret nz  ; player won and is first, both are in place
    call _SwapTournamentTrainers
    ret

; this is supposed to be called after a match
TPTUpdateBrackets:
    ld a, [wTPTNextMatch]
    ld e, a
    ld a, [wTPTNextMatch + 1]
    ld d, a
    ; de is now pointing to the correct data entry
    inc de      ; skip offset to current match

    ld a, [de]  ; get offset to store winner
    ld b, 0
    ld c, a
    ld hl, wTPTBrackets
    add hl, bc
    ld a, [wTPTMatchWinner]
    ld [hl], a

    inc de
    ld a, [de]  ; get offset to store loser
    ld c, a
    ld hl, wTPTBrackets
    add hl, bc
    ld a, [wTPTMatchLoser]
    ld [hl], a

    inc de
; check if there is a following match
    ld a, [de]
    sub -1      ; will be zero (FALSE) if there is no following match
    ld [wScriptVar], a
    and a
    jr nz, .has_next
    inc de      ; move into the next round
.has_next       ; save pointer to next match
    ld hl, wTPTNextMatch
    ld [hl], e
    inc hl
    ld [hl], d
	ret


TPTSimulateMatch:
    call Random
    bit 0, a
    ret nz ; leave trainers as they are
    call _SwapTournamentTrainers
    ret


;TPTStartNextRound:
;    jumptable TPTRoundCallbacks, wTPTRoundIndex


;TPTRoundCallbacks:
;    dw TPTWinners1Callback

;TPTWinners1Callback:
;    call TPTInitializeWinners1
;    ret

TPTInitializeWinners1:
; [Johto Gym Leaders] vs [Kanto Gym Leaders]
    ld de, wTPTWinnersBracket
    ld c, OFFSET_JOHTO_CLASSES
    call InitializeRegionTrainers

    ld de, wTPTWinnersBracket + 1
    ld c, OFFSET_KANTO_CLASSES
    call InitializeRegionTrainers

    ld b, 0
    ld c, 16
    xor a
    ld hl, wTPTLosersBracket
    call ByteFill   ; fill loser's bracket with zeroes

    ld de, TPTWinnersRound1Matches
    ld hl, wTPTNextMatch
    ld [hl], e
    inc hl
    ld [hl], d
    ;ld a, TPT_TOURNAMENT_START_FLAG
    ;ld [wTPTVar], a
    ret


TPTInitializeWinners2:
; [Winners of Round 1] vs [Elite Trainers]
    ld de, wTPTWinnersBracket
    inc de
    ld c, OFFSET_ELITE_CLASSES
    call InitializeRegionTrainers

    ld de, TPTWinnersRound2Matches
    ld hl, wTPTNextMatch
    ld [hl], e
    inc hl
    ld [hl], d
    ;ld a, TPT_TOURNAMENT_START_FLAG
    ;ld [wTPTVar], a
    ret


INCLUDE "data/trainers/shuffles.asm"

InitializeRegionTrainers:
; assumes that de is pointing to the first slot
; assumes that c equals the trainer class offset (J,K,E)
    push bc
    ld a, NUM_GYM_LEADERS
    call RandomRange
    add a, a    ; times 2
    add a, a    ; times 4 (4 bytes per shuffle)
    ld b, 0
    ld c, a
    ld hl, TrainerShuffles
    add hl, bc  ; go to random shuffle
    pop bc

    ; Trainer 1
    ld a, [hl]
    swap a
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    ;or $00     ; use first team
    ld [de], a

    ; Trainer 2
    inc de      ; skip trainer from another class
    inc de      ; skip to next match
    ld a, [hli]
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    or TRAINER_SET_TEAM2 ; use second team
    ld [de], a

    ; Trainer 3
    inc de
    inc de
    ld a, [hl]
    swap a
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    or TRAINER_SET_TEAM3 ; use third team
    ld [de], a

    ; Trainer 4
    inc de
    inc de
    ld a, [hli]
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    or TRAINER_SET_TEAM4 ; use fourth team
    ld [de], a

    ; Trainer 5
    inc de
    inc de
    ld a, [hl]
    swap a
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    ;or $00     ; use first team
    ld [de], a

    ; Trainer 6
    inc de
    inc de
    ld a, [hli]
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    or TRAINER_SET_TEAM2 ; use second team
    ld [de], a

    ; Trainer 7
    inc de
    inc de
    ld a, [hl]
    swap a
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    or TRAINER_SET_TEAM3 ; use third team
    ld [de], a

    ; Trainer 8
    inc de
    inc de
    ld a, [hli]
    and CLASS_OFFSET_BIT_MASK
    add a, c
    inc a       ; classes start at 1
    or TRAINER_SET_TEAM4 ; use fourth team
    ld [de], a

    ret

; **************************************************************************************************
;   HELPER FUNCTIONS
; **************************************************************************************************

_SetOTClassAndID:
; assumes that `hl` points either to `wTPTTrainer1` or `wTPTTrainer2`
    ld a, [hl]
    and TRAINER_CLASS_BIT_MASK  ; get the trainer's class
    ld [wOtherTrainerClass], a
    ld a, [hl]
    and TRAINER_TEAM_BIT_MASK   ; get the trainer's ID
    ; shift right (sra) 5 times is 40 cycles
    ; swap (upper with lower) and shift right (sra) is 16 cycles
    ; rotate right (rrca) 5 times is 20 cycles
    ; rotate left (rlca) 3 times is 12 cycles
    rlca
    rlca
    rlca
    inc a                       ; IDs start at 1
    ld [wOtherTrainerID], a
    ret

_LoadVariableClassSprite:
; input: `b` contains the variable trainer sprite (e.g., SPRITE_TOURNAMENT_TRAINER1)
; input: `c` contains the trainer class (e.g., FALKNER)
    ld hl, TrainerClassSprites
    ld a, c
    dec a
    ld e, a
    ld d, 0
    add hl, de
    ld a, b
    ld e, a
    ld a, [hl]  ; `a` contains the trainer sprite (e.g., SPRITE_FALKNER)
    ld hl, wVariableSprites
    add hl, de
    ld [hl], a
    ret

_SwapTournamentTrainers:    
    ld a, [wTPTTrainer1]
    ld b, a
    ld a, [wTPTTrainer2]
    ld [wTPTMatchWinner], a
    ld a, b
    ld [wTPTMatchLoser], a
    ld hl, wTPTMatchWinner
    call _SetOTClassAndID
    ld de, wRedsName
    farcall CopyTrainerNameToDE
    ld hl, wTPTMatchLoser
    call _SetOTClassAndID
    ld de, wGreensName
    farcall CopyTrainerNameToDE
    ret
