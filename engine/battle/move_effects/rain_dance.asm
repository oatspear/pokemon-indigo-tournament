BattleCommand_StartRain:
; startrain
	call ResetWeatherEffects
	ld a, WEATHER_RAIN
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, DownpourText
	call StdBattleTextbox

; apply speed boosts
	ld a, [wBattleMonAbility]
	cp SWIFT_SWIM
	jr nz, .enemy
	ld hl, wBattleMonSpeed
	call DoubleBattleStat

.enemy
	ld a, [wEnemyMonAbility]
	cp SWIFT_SWIM
	ret nz
	ld hl, wEnemyMonSpeed
	jp DoubleBattleStat
