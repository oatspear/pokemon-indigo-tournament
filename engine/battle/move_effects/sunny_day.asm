BattleCommand_StartSun:
; startsun
	ld a, WEATHER_SUN
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, SunGotBrightText
	call StdBattleTextbox

; apply speed boosts
	ld a, [wBattleMonAbility]
	cp CHLOROPHYLL
	jr nz, .enemy
	ld hl, wBattleMonSpeed
	call DoubleBattleStat

.enemy
	ld a, [wEnemyMonAbility]
	cp CHLOROPHYLL
	ret nz
	ld hl, wEnemyMonSpeed
	jp DoubleBattleStat
