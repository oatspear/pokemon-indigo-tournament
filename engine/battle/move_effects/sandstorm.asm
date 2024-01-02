BattleCommand_StartSandstorm:
; startsandstorm

	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr z, .failed

	call ResetWeatherEffects
	ld a, WEATHER_SANDSTORM
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	call AnimateCurrentMove
	ld hl, SandstormBrewedText
	call StdBattleTextbox

; apply speed boosts
	ld a, [wBattleMonAbility]
	cp SAND_RUSH
	jr nz, .enemy
	ld hl, wBattleMonSpeed
	call DoubleBattleStat

.enemy
	ld a, [wEnemyMonAbility]
	cp SAND_RUSH
	ret nz
	ld hl, wEnemyMonSpeed
	jp DoubleBattleStat

.failed
	call AnimateFailedMove
	jp PrintButItFailed
