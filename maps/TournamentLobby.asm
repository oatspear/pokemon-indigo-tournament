    object_const_def
    const TOURNAMENTLOBBY_RECEPTIONIST
	const TOURNAMENTLOBBY_REGISTRAR
	const TOURNAMENTLOBBY_VENDOR
	const TOURNAMENTLOBBY_OFFICER

TournamentLobby_MapScripts:
    def_scene_scripts

    def_callbacks
    callback MAPCALLBACK_NEWMAP, .Initialize

.Initialize:
    checkevent EVENT_INITIALIZED_EVENTS
    iftrue .SkipInitialization
    jumpstd InitializeEventsScript
.SkipInitialization:
    endcallback


; **************************************************************************************************
; TOURNAMENT LOBBY NPC SCRIPTS
; **************************************************************************************************

TournamentOfficerScript:
    faceplayer
    opentext
    writetext TournamentOfficerRegisterFirstText
    waitbutton
    closetext
    end

TournamentReceptionistScript:
    faceplayer
    opentext
    writetext TournamentReceptionistWelcomeText
    yesorno
    iffalse .SeeYou
    writetext TournamentReceptionistRulesText
    sjump .Done

.SeeYou:
    writetext TournamentReceptionistSeeYouText

.Done:
    waitbutton
    closetext
    end

TournamentRegistrarScript:
    faceplayer
    opentext
    writetext TournamentRegistrarAreYouReadyText
    yesorno
    iftrue .RegisterAndStart
    writetext TournamentRegistrarNotReadyText
    waitbutton
    closetext
    end

.RegisterAndStart:
    writetext TournamentRegistrarVeryWellText
    promptbutton
    waitsfx
    closetext
    applymovement TOURNAMENTLOBBY_REGISTRAR, TournamentRegistrarGoToPCMovement
    opentext
    writetext TournamentRegistrarDotDotDotText
    playsound SFX_REGISTER_PHONE_NUMBER
    waitsfx
    closetext
    applymovement TOURNAMENTLOBBY_REGISTRAR, TournamentRegistrarReturnToPlayerMovement
    opentext
    promptbutton
    writetext TournamentRegistrarAllDoneText
    waitbutton
    closetext
    playsound SFX_ENTER_DOOR
    special FadeOutPalettes
    waitsfx
    warp TOURNAMENT_STADIUM, 9, 8
    end

TournamentVendorScript:
    faceplayer
    opentext
    writetext TournamentVendorNYIText
    waitbutton
    closetext
    end


; **************************************************************************************************
; TOURNAMENT LOBBY NPC MOVEMENT
; **************************************************************************************************

TournamentRegistrarGoToPCMovement:
    step RIGHT
    turn_head UP
    step_end

TournamentRegistrarReturnToPlayerMovement:
    step LEFT
    turn_head UP
    step_end


; **************************************************************************************************
; TOURNAMENT LOBBY NPC TEXT
; **************************************************************************************************

TournamentReceptionistWelcomeText:
    text "Welcome to the"
    line "Indigo Plateau"
    cont "#MON League!"

    para "I see that you are"
    line "here to compete."

    para "Do you want me to"
    line "explain the"
    cont "Tournament rules?"
    done

TournamentReceptionistRulesText:
    text "(To be done.)"
    done

TournamentReceptionistSeeYouText:
    text "Let me know if"
    line "you need help."
    done


TournamentRegistrarAreYouReadyText:
    text "Greetings. I am"
    line "the Tournament's"
    cont "registrar."

    para "I have to register"
    line "your trainer ID"
    cont "and your #MON"
    cont "team in our system"
    cont "before we start."

    para "So, are you ready"
    line "to do battle?"
    done

TournamentRegistrarVeryWellText:
    text "Very well. Just"
    line "a moment, please."
    done

TournamentRegistrarDotDotDotText:
    text "<……>"
    line "<……>"
    done

TournamentRegistrarAllDoneText:
    text "All done! You may"
    line "now go to the"
    cont "battle arena."

    para "The battles will"
    line "start shortly."
    done

TournamentRegistrarNotReadyText:
    text "Alright. Do what"
    line "you need to do."

    para "Let me know when"
    line "you are ready."
    done


TournamentVendorNYIText:
    text "This NPC is not"
    line "yet implemented."
    done


TournamentOfficerRegisterFirstText:
    text "I am sorry, but I"
    line "cannot allow you"
    cont "to pass."

    para "We are still"
    line "preparing every-"
    cont "thing for the "
    cont "battles to come."

    para "Take this time"
    line "to prepare your"
    cont "team and register"
    cont "at the counter."

    para "The tournament"
    line "should start soon."
    done


; **************************************************************************************************
; TOURNAMENT LOBBY MAP EVENTS
; **************************************************************************************************

TournamentLobby_MapEvents:
    db 0, 0 ; filler

    def_warp_events
    warp_event  2, 7, INDIGO_PLATEAU_POKECENTER_1F, 4
    warp_event  3, 7, INDIGO_PLATEAU_POKECENTER_1F, 4
    warp_event 17, 0, TOURNAMENT_STADIUM, 2

    def_coord_events

    def_bg_events

    def_object_events
    object_event  7,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TournamentReceptionistScript, -1
    object_event  8,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TournamentRegistrarScript, -1
    object_event 11,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TournamentVendorScript, -1
    object_event 16,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, TournamentOfficerScript, -1
