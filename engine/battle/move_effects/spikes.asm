BattleCommand_Spikes:
; spikes

	ld hl, wEnemyScreens
	ld de, wEnemyHazardLayers
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
	ld de, wPlayerHazardLayers
.got_screens

; must check how many layers are already down

	bit SCREENS_SPIKES, [hl]
	jr z, .can_lay_down

    push hl
    ld l, e
    ld h, d
	ld a, [hl]
	pop hl
	and SPIKES_LAYER_MASK
	cp SPIKES_MAX_LAYERS
	jp nc, FailMove

; Nothing else stops it from working.

.can_lay_down
	set SCREENS_SPIKES, [hl]
    ld l, e
    ld h, d
	inc [hl]

	call AnimateCurrentMove

	ld hl, SpikesText
	jp StdBattleTextbox
