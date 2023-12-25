INCLUDE "data/trainers/party_pointers.asm"

Trainers:
; Trainer data structure:
; - db "NAME@"
; - 1 to 6 Pokémon:
;    * db species, item, ability, EV bit field, 4 moves
; - db -1 ; end

Rival1Group:
PKMNTrainerGroup:
ScientistGroup:
YoungsterGroup:
SchoolboyGroup:
BirdKeeperGroup:
LassGroup:
CooltrainerMGroup:
CooltrainerFGroup:
BeautyGroup:
PokemaniacGroup:
GruntMGroup:
GentlemanGroup:
SkierGroup:
TeacherGroup:
BugCatcherGroup:
FisherGroup:
SwimmerMGroup:
SwimmerFGroup:
SailorGroup:
SuperNerdGroup:
Rival2Group:
GuitaristGroup:
HikerGroup:
BikerGroup:
BurglarGroup:
FirebreatherGroup:
JugglerGroup:
BlackbeltGroup:
ExecutiveMGroup:
PsychicGroup:
PicnickerGroup:
CamperGroup:
ExecutiveFGroup:
SageGroup:
MediumGroup:
BoarderGroup:
PokefanMGroup:
KimonoGirlGroup:
TwinsGroup:
PokefanFGroup:
OfficerGroup:
GruntFGroup:
PokemonProfGroup:
MysticalmanGroup:

FalknerGroup:
BugsyGroup:
WhitneyGroup:
MortyGroup:
ChuckGroup:
JasmineGroup:
PryceGroup:
ClairGroup:
BrockGroup:
MistyGroup:
LtSurgeGroup:
ErikaGroup:
JanineGroup:
SabrinaGroup:
BlaineGroup:
BlueGroup:
WillGroup:
KogaGroup:
BrunoGroup:
KarenGroup:
ChampionGroup:
RedGroup:
GiovanniGroup:
GreenGroup:
	; TESTER (1)
	db "TESTER 1@"
	db DEWGONG,  LEFTOVERS, DRY_SKIN,    0, RAIN_DANCE, SURF, FREEZE_DRY, FLIP_TURN
	db BAYLEEF,  LEFTOVERS, DRY_SKIN,   0, RAZOR_LEAF, BODY_SLAM, EARTHQUAKE, REFLECT
	db QUILAVA,  LEFTOVERS, DRY_SKIN,   0, OVERHEAT, QUICK_ATTACK, DIG, WILL_O_WISP
	db CROCONAW, LEFTOVERS, DRY_SKIN, 0, WATERFALL, SLASH, NIGHT_SLASH, FLIP_TURN
	db JOLTEON,  LEFTOVERS, DRY_SKIN,  0, THUNDER, VOLT_SWITCH, THUNDER_WAVE, U_TURN
	db HAUNTER,  LEFTOVERS, DRY_SKIN,     0, SHADOW_BALL, NASTY_PLOT, FROST_BREATH, THUNDERBOLT
	db -1 ; end

	; TESTER (2)
	db "TESTER 2@"
	db BAYLEEF,  LEFTOVERS, SAP_SIPPER,   0, RAZOR_LEAF, BODY_SLAM, EARTHQUAKE, REFLECT
	db QUILAVA,  LEFTOVERS, FLASH_FIRE,   0, OVERHEAT, QUICK_ATTACK, DIG, WILL_O_WISP
	db CROCONAW, LEFTOVERS, WATER_ABSORB, 0, WATERFALL, SLASH, NIGHT_SLASH, FLIP_TURN
	db JOLTEON,  LEFTOVERS, VOLT_ABSORB,  0, THUNDER, VOLT_SWITCH, THUNDER_WAVE, U_TURN
	db HAUNTER,  LEFTOVERS, LEVITATE,     0, SHADOW_BALL, NASTY_PLOT, FROST_BREATH, THUNDERBOLT
	db DUGTRIO,  LEFTOVERS, MOLD_BREAKER, 0, EARTHQUAKE, NIGHT_SLASH, WILD_CHARGE, U_TURN
	db -1 ; end

	; TESTER (3)
	db "TESTER 3@"
	db BAYLEEF,  LEFTOVERS, SAP_SIPPER,   0, RAZOR_LEAF, BODY_SLAM, EARTHQUAKE, REFLECT
	db QUILAVA,  LEFTOVERS, FLASH_FIRE,   0, OVERHEAT, QUICK_ATTACK, DIG, WILL_O_WISP
	db CROCONAW, LEFTOVERS, WATER_ABSORB, 0, WATERFALL, SLASH, NIGHT_SLASH, FLIP_TURN
	db JOLTEON,  LEFTOVERS, VOLT_ABSORB,  0, THUNDER, VOLT_SWITCH, THUNDER_WAVE, U_TURN
	db HAUNTER,  LEFTOVERS, LEVITATE,     0, SHADOW_BALL, NASTY_PLOT, FROST_BREATH, THUNDERBOLT
	db DUGTRIO,  LEFTOVERS, MOLD_BREAKER, 0, EARTHQUAKE, NIGHT_SLASH, WILD_CHARGE, U_TURN
	db -1 ; end

	; TESTER (4)
	db "TESTER 4@"
	db BAYLEEF,  LEFTOVERS, SAP_SIPPER,   0, RAZOR_LEAF, BODY_SLAM, EARTHQUAKE, REFLECT
	db QUILAVA,  LEFTOVERS, FLASH_FIRE,   0, OVERHEAT, QUICK_ATTACK, DIG, WILL_O_WISP
	db CROCONAW, LEFTOVERS, WATER_ABSORB, 0, WATERFALL, SLASH, NIGHT_SLASH, FLIP_TURN
	db JOLTEON,  LEFTOVERS, VOLT_ABSORB,  0, THUNDER, VOLT_SWITCH, THUNDER_WAVE, U_TURN
	db HAUNTER,  LEFTOVERS, LEVITATE,     0, SHADOW_BALL, NASTY_PLOT, FROST_BREATH, THUNDERBOLT
	db DUGTRIO,  LEFTOVERS, MOLD_BREAKER, 0, EARTHQUAKE, NIGHT_SLASH, WILD_CHARGE, U_TURN
	db -1 ; end
