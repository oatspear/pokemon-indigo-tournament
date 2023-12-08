BattleCommand_StartHail:
; starthail
	ld a, WEATHER_HAIL
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, ItStartedToHailText
	call StdBattleTextbox

; apply speed boosts
	ld a, [wBattleMonAbility]
	cp SLUSH_RUSH
	jr nz, .enemy
	ld hl, wBattleMonSpeed
	call DoubleBattleStat

.enemy
	ld a, [wEnemyMonAbility]
	cp SLUSH_RUSH
	ret nz
	ld hl, wEnemyMonSpeed
	jp DoubleBattleStat
