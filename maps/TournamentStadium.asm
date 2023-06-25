    object_const_def
    const TOURNAMENTSTADIUM_GUIDE
    const TOURNAMENTSTADIUM_REFEREE
    const TOURNAMENTSTADIUM_TRAINER1
	const TOURNAMENTSTADIUM_TRAINER2
	const TOURNAMENTSTADIUM_OAK
	const TOURNAMENTSTADIUM_SILVER
	const TOURNAMENTSTADIUM_CRYSTAL

TournamentStadium_MapScripts:
    def_scene_scripts
    scene_script .Initialize ; SCENE_TOURNAMENTSTADIUM_NOT_STARTED
    scene_script .DummyScene ; SCENE_TOURNAMENTSTADIUM_STARTED
    scene_script .DummyScene ; SCENE_TOURNAMENTSTADIUM_BATTLING

    def_callbacks
    ; callback MAPCALLBACK_NEWMAP, .Initialize

.DummyScene:
    end

.Initialize:
    loadmem wTPTRound, TPT_WINNERS_ROUND_1
    special TPTInitializeWinners1
    special TPTLoadNextMatch
    disappear TOURNAMENTSTADIUM_TRAINER1
    disappear TOURNAMENTSTADIUM_TRAINER2
    setscene SCENE_TOURNAMENTSTADIUM_STARTED
    end


; **************************************************************************************************
; TOURNAMENT STADIUM LOGIC SCRIPTS
; **************************************************************************************************

TournamentStadiumNotLeaving:
    showemote EMOTE_SHOCK, PLAYER, 15
    opentext
    writetext TournamentNotLeavingText
    waitbutton
    closetext
    turnobject PLAYER, UP
    applymovement PLAYER, TournamentNotLeavingMovement
    end

TournamentStadiumStartWatchingUpperRow:
    turnobject PLAYER, DOWN
    sjump TournamentStadiumStartWatching

TournamentStadiumStartWatchingLowerRow:
    turnobject PLAYER, UP
    sjump TournamentStadiumStartWatching

TournamentStadiumStartWatching:
    opentext
    writetext TournamentIntroText
    waitbutton
    closetext
    pause 15
    ; fallthrough to TournamentStadiumFirstMatchOfRound


TournamentStadiumFirstMatchOfRound:
    opentext
    writetext TournamentFirstMatchText
    waitbutton
    closetext
    setscene SCENE_TOURNAMENTSTADIUM_BATTLING
    ; fallthrough to TournamentStadiumLoadBattleScene

TournamentStadiumLoadBattleScene:
    special FadeBlackQuickly
    disappear TOURNAMENTSTADIUM_TRAINER1
    disappear TOURNAMENTSTADIUM_TRAINER2
    pause 15
; not needed, TPTLoadNextMatch handles the sprites
    ;variablesprite SPRITE_TOURNAMENT_TRAINER1, SPRITE_OAK
    ;variablesprite SPRITE_TOURNAMENT_TRAINER2, SPRITE_SILVER
    appear TOURNAMENTSTADIUM_TRAINER1
    appear TOURNAMENTSTADIUM_TRAINER2
    special LoadUsedSpritesGFX
    pause 15
    playsound SFX_ELEVATOR_END
    waitsfx
    special FadeInQuickly

    opentext
    writetext TournamentStartBattleText
    ;writetext DebugTPTPointer
    waitbutton
    closetext

; sending out their mons
    ;opentext
    ;writetext TournamentTrainersBattleText
    ;waitbutton
    ;closetext

    opentext
.ChooseTrainer:
    writetext TournamentRootForTrainer1Text
    yesorno
    iftrue .LoadParty1
    writetext TournamentRootForTrainer2Text
    yesorno
    iftrue .LoadParty2
    writetext TournamentRootForNoOneText
    yesorno
    iffalse .ChooseTrainer
    sjump .SkipBattle

.LoadParty1
    special TPTReadTrainerPartiesPlayer1
    sjump .ChoiceDone
.LoadParty2
    special TPTReadTrainerPartiesPlayer2

.ChoiceDone:
    closetext

	winlosstext DummyWinText, DummyLossText
	special TPTPlayerBattle
	reloadmapafterbattle

.AfterBattle:
    opentext
    writetext TournamentBattleWinnerText
    promptbutton
    checklosersbracket
    iffalse .amazing_battle
    writetext TournamentLoserEliminatedText
    promptbutton
.amazing_battle
    writetext TournamentAmazingBattleText
    ;writetext DebugTPTPointer
    waitbutton
    closetext

	special TPTUpdateBrackets ; will set FALSE if there is no following match
    iffalse .EndOfRound

; Next Match
    special TPTLoadNextMatch
    opentext
    writetext TournamentNextMatchText
    waitbutton
    closetext
    sjump TournamentStadiumLoadBattleScene

.SkipBattle:
    closetext
    special FadeBlackQuickly
    pause 15
    playsound SFX_SCRATCH
    waitsfx
    pause 15
    playsound SFX_POUND
    waitsfx
    pause 15
    playsound SFX_SWITCH_POKEMON
    waitsfx
    pause 15
    playsound SFX_TACKLE
    waitsfx
    pause 15
    special FadeInQuickly
    special TPTSimulateMatch
    sjump .AfterBattle

.EndOfRound:
    opentext
    writetext TournamentEndOfRoundText
    playsound SFX_DEX_FANFARE_50_79
    waitsfx
    promptbutton
    closetext

    readmem wTPTRound
    ifequal TPT_WINNERS_ROUND_1, TournamentStadiumWinnersRound2
    ifequal TPT_WINNERS_ROUND_2, TournamentStadiumLosersRound1
    ifequal TPT_LOSERS_ROUND_1,  TournamentStadiumWinnersRound3
    ifequal TPT_WINNERS_ROUND_3, TournamentStadiumLosersRound2
    ifequal TPT_LOSERS_ROUND_2,  TournamentStadiumLosersRound3
    ifequal TPT_LOSERS_ROUND_3,  TournamentStadiumWinnersRound4
    ifequal TPT_WINNERS_ROUND_4, TournamentStadiumLosersRound4
    ifequal TPT_LOSERS_ROUND_4,  TournamentStadiumLosersRound5
    ifequal TPT_LOSERS_ROUND_5,  TournamentStadiumWinnersRound5
    ifequal TPT_WINNERS_ROUND_5, TournamentStadiumLosersRound6
    ifequal TPT_LOSERS_ROUND_6,  TournamentStadiumLosersRound7
    ifequal TPT_LOSERS_ROUND_7,  TournamentStadiumWinnersRound6
    ;ifequal TPT_WINNERS_ROUND_6, .EndOfTournament

;.EndOfTournament:
    opentext
    writetext TournamentEndedText
    waitbutton
    closetext

    pause 30
	special HealParty
	refreshscreen
	credits
	end

TournamentStadiumWinnersRound2:
    loadmem wTPTRound, TPT_WINNERS_ROUND_2
    special TPTInitializeWinners2
    special TPTLoadNextMatch

    opentext
    writetext TournamentWinnersRound2Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumLosersRound1:
    loadmem wTPTRound, TPT_LOSERS_ROUND_1
    special TPTLoadNextMatch

    opentext
    writetext TournamentLosersRound1Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumWinnersRound3:
    loadmem wTPTRound, TPT_WINNERS_ROUND_3
    special TPTLoadNextMatch

    opentext
    writetext TournamentWinnersRound3Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumLosersRound2:
    loadmem wTPTRound, TPT_LOSERS_ROUND_2
    special TPTLoadNextMatch

    opentext
    writetext TournamentLosersRound2Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumLosersRound3:
    loadmem wTPTRound, TPT_LOSERS_ROUND_3
    special TPTLoadNextMatch

    opentext
    writetext TournamentLosersRound3Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumWinnersRound4:
    loadmem wTPTRound, TPT_WINNERS_ROUND_4
    special TPTLoadNextMatch

    opentext
    writetext TournamentWinnersRound4Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumLosersRound4:
    loadmem wTPTRound, TPT_LOSERS_ROUND_4
    special TPTLoadNextMatch

    opentext
    writetext TournamentLosersRound4Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumLosersRound5:
    loadmem wTPTRound, TPT_LOSERS_ROUND_5
    special TPTLoadNextMatch

    opentext
    writetext TournamentLosersRound5Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumFirstMatchOfRound

TournamentStadiumWinnersRound5:
    loadmem wTPTRound, TPT_WINNERS_ROUND_5
    special TPTLoadNextMatch

    opentext
    writetext TournamentWinnersRound5Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumLoadBattleScene

TournamentStadiumLosersRound6:
    loadmem wTPTRound, TPT_LOSERS_ROUND_6
    special TPTLoadNextMatch

    opentext
    writetext TournamentLosersRound6Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumLoadBattleScene

TournamentStadiumLosersRound7:
    loadmem wTPTRound, TPT_LOSERS_ROUND_7
    special TPTLoadNextMatch

    opentext
    writetext TournamentLosersRound7Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumLoadBattleScene

TournamentStadiumWinnersRound6:
    loadmem wTPTRound, TPT_WINNERS_ROUND_6
    special TPTLoadNextMatch

    opentext
    writetext TournamentWinnersRound6Text
    waitbutton
    closetext

    pause 15
    sjump TournamentStadiumLoadBattleScene


; **************************************************************************************************
; TOURNAMENT STADIUM NPC SCRIPTS
; **************************************************************************************************

TournamentRefereeScript:
    faceplayer
    opentext
    writetext RefereeWelcomeText
	waitbutton
    closetext
    turnobject TOURNAMENTSTADIUM_REFEREE, DOWN
    end

TournamentOakScript:
    faceplayer
    opentext
    writetext OakGoodToSeeYouText
	waitbutton
    closetext
    turnobject TOURNAMENTSTADIUM_OAK, DOWN
    end

TournamentSilverScript:
    faceplayer
    opentext
    writetext SilverLateAsUsualText
	waitbutton
    closetext
    turnobject TOURNAMENTSTADIUM_SILVER, UP
    end

TournamentCrystalScript:
    faceplayer
    opentext
    writetext CrystalSoExcitedText
	waitbutton
    closetext
    turnobject TOURNAMENTSTADIUM_CRYSTAL, UP
    end


; **************************************************************************************************
; TOURNAMENT STADIUM MOVEMENT
; **************************************************************************************************

TournamentNotLeavingMovement:
    step UP
    step_end


; **************************************************************************************************
; TOURNAMENT STADIUM NPC TEXT
; **************************************************************************************************

TournamentNotLeavingText:
    text "I am not leaving"
    line "when there are"
    cont "battles with"
    cont "powerful trainers"
    cont "about to start."
    done

RefereeWelcomeText:
    text "Welcome, esteemed"
    line "trainer! Please"
    cont "choose a place"
    cont "from which you"
    cont "would like to"
    cont "watch the battles."
    done

OakGoodToSeeYouText:
    text "Ah, <PLAYER>!"
    line "Good to see you!"

    para "Huh? Your #DEX?"
    line "I will rate it"
    cont "later."

    para "Come now, let us"
    line "watch some great"
    cont "#MON battles!"
    done

SilverLateAsUsualText:
    text "Late as usual,"
    line "<PLAYER>."

    para "Quit fooling"
    line "around. Let us"
    cont "watch the battles."
    done

CrystalSoExcitedText:
    text "I am so excited"
    line "to watch these"
    cont "matches from up"
    cont "close!"

    para "We were lucky to"
    line "be given these"
    cont "VIP tickets!"
    done


TournamentIntroText:
    text "#MON REFEREE:"
    line "Welcome to the"
    cont "Indigo Plateau"
    cont "Tournament of"
    cont "Power!"

    para "We will now"
    line "begin a series"
    cont "of matches to"
    cont "determine the"
    cont "best #MON"
    cont "trainers in both"
    cont "JOHTO and KANTO!"

    para "Are you ready?"
    done

TournamentFirstMatchText:
    text "#MON REFEREE:"
    line "Our first match"
    cont "will be…"

    para "<RED> vs"
    line "<GREEN>!"

    para "Trainers!"
    line "To the arena!"
    done

TournamentNextMatchText:
    text "#MON REFEREE:"
    line "Our next match"
    cont "will be…"

    para "<RED> vs"
    line "<GREEN>!"

    para "Trainers!"
    line "To the arena!"
    done

TournamentStartBattleText:
    text "#MON REFEREE:"
    line "Let the battle"
    cont "begin!"
    done

TournamentBattleWinnerText:
    text "#MON REFEREE:"
    line "The winner is…"
    cont "<RED>!"
    done

TournamentLoserEliminatedText:
    text "<GREEN> has been"
    line "eliminated from"
    cont "the Tournament!"
    done

TournamentAmazingBattleText:
    text "Wow! What an"
    line "amazing battle!"
    done


TournamentRootForTrainer1Text:
    text "(Are you rooting"
    line "for <RED>?)"
    done

TournamentRootForTrainer2Text:
    text "(Are you rooting"
    line "for <GREEN>?)"
    done

TournamentRootForNoOneText:
    text "(Do you want to"
    line "skip this battle?)"
    done


TournamentEndOfRoundText:
    text "#MON REFEREE:"
    line "This Tournament"
    cont "round has ended!"
    done


TournamentWinnersRound2Text:
    text "#MON REFEREE:"
    line "Next we have the"
    cont "2nd Round of the"
    cont "Winner's Bracket,"
    cont "with an exciting"
    cont "surprise!"

    para "Elite #MON"
    line "Trainers will join"
    cont "us to turn up the"
    cont "heat of battle!"
    done

TournamentLosersRound1Text:
    text "#MON REFEREE:"
    line "We move now to the"
    cont "1st Round of the"
    cont "Loser's Bracket."

    para "Let us watch"
    line "Trainers battle"
    cont "their way up for"
    cont "a chance at the"
    cont "finals."
    done

TournamentWinnersRound3Text:
    text "#MON REFEREE:"
    line "We are now enter-"
    cont "ing the Quarter"
    cont "Finals of the"
    cont "Winner's Bracket!"

    para "Can you feel the"
    line "excitement?"
    done

TournamentLosersRound2Text:
    text "#MON REFEREE:"
    line "Let us go back now"
    cont "to the Quarter"
    cont "Finals of the"
    cont "Loser's Bracket!"
    done

TournamentLosersRound3Text:
    text "#MON REFEREE:"
    line "The 2nd Round of"
    cont "Loser's Bracket"
    cont "Quarter Finals is"
    cont "about to start!"
    done

TournamentWinnersRound4Text:
    text "#MON REFEREE:"
    line "Time to watch the"
    cont "Winner's Bracket"
    cont "Semi Finals!"
    done

TournamentLosersRound4Text:
    text "#MON REFEREE:"
    line "The back and forth"
    cont "ensues, with the"
    cont "Loser's Bracket"
    cont "Semi Finals"
    cont "coming next."
    done

TournamentLosersRound5Text:
    text "#MON REFEREE:"
    line "The 2nd Round of"
    cont "the Loser's Semi"
    cont "Finals is about"
    cont "to start."

    para "The stakes are"
    line "high now!"
    done

TournamentWinnersRound5Text:
    text "#MON REFEREE:"
    line "Here we are, my"
    cont "good audience!"

    para "The next round"
    line "is going to be"
    cont "the Finals of the"
    cont "Winner's Bracket!"

    para "We will now"
    line "determine our"
    cont "interim Champion!"

    para "<RED> vs"
    line "<GREEN>!"

    para "Trainers!"
    line "To the arena!"
    done

TournamentLosersRound6Text:
    text "#MON REFEREE:"
    line "What a day to be"
    cont "alive, folks!"
    cont "These Trainers"
    cont "are really"
    cont "something else!"

    para "Let us watch now"
    line "who will try to"
    cont "claim the title!"

    para "Let us begin the"
    line "Loser's Bracket"
    cont "Finals!"

    para "<RED> vs"
    line "<GREEN>!"

    para "Trainers!"
    line "To the arena!"
    done

TournamentLosersRound7Text:
    text "#MON REFEREE:"
    line "Only one more"
    cont "round remains in"
    cont "the Finals of the"
    cont "Loser's Bracket!"

    para "The winner will"
    line "earn the right to"
    cont "challenge our"
    cont "interim Champion."

    para "Can it get more"
    line "intense than this?"
    cont "I am not sure."
    cont "Now…"

    para "<RED> vs"
    line "<GREEN>!"

    para "Trainers!"
    line "To the arena!"
    done

TournamentWinnersRound6Text:
    text "#MON REFEREE:"
    line "The moment we have"
    cont "been waiting for!"

    para "The winner of the"
    line "next match claims"
    cont "all! Let us watch"
    cont "who will rise as"
    cont "The Tournament's"
    cont "Champion!!"

    para "Ladies!"
    line "Gentlemen!"

    para "<RED> vs"
    line "<GREEN>!!"
    done

TournamentEndedText:
    text "#MON REFEREE:"
    line "That's it!"

    para "We hope that you"
    line "have enjoyed these"
    cont "matches as much as"
    cont "we did!"

    para "We hope to see you"
    line "again, sometime!"
    done


DummyIntroText:
	text "Let's do it!"
	done

DummyWinText:
	text "All right!"
	line "Let's do it again"
	cont "sometime."
	done

DummyLossText:
	text "I won! Better"
	line "luck next time."
	done


; **************************************************************************************************
; TOURNAMENT STADIUM MAP EVENTS
; **************************************************************************************************

TournamentStadium_MapEvents:
    db 0, 0 ; filler

    def_warp_events
    warp_event  9, 13, TOURNAMENT_LOBBY, 3
    warp_event 10, 13, TOURNAMENT_LOBBY, 3

    def_coord_events
    coord_event  9, 13, SCENE_TOURNAMENTSTADIUM_STARTED, TournamentStadiumNotLeaving
    coord_event 10, 13, SCENE_TOURNAMENTSTADIUM_STARTED, TournamentStadiumNotLeaving
    coord_event  8,  2, SCENE_TOURNAMENTSTADIUM_STARTED, TournamentStadiumStartWatchingUpperRow
    coord_event 11,  2, SCENE_TOURNAMENTSTADIUM_STARTED, TournamentStadiumStartWatchingUpperRow
    coord_event  8,  6, SCENE_TOURNAMENTSTADIUM_STARTED, TournamentStadiumStartWatchingLowerRow
    coord_event 11,  6, SCENE_TOURNAMENTSTADIUM_STARTED, TournamentStadiumStartWatchingLowerRow

    def_bg_events

    def_object_events
    object_event  8,  9, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
    object_event  9,  2, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TournamentRefereeScript, -1
    object_event  7,  4, SPRITE_TOURNAMENT_TRAINER1, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
    object_event 12,  3, SPRITE_TOURNAMENT_TRAINER2, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
    object_event 10,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TournamentOakScript, -1
    object_event  9,  6, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TournamentSilverScript, -1
    object_event 10,  6, SPRITE_KRIS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TournamentCrystalScript, -1
