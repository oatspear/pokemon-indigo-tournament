
; This table contains offsets, counting from wTPTBrackets
;   from which the scripts should read/write match data.
; Index 0 refers to the first match, 1 to the second, etc.
; Each match contains three bytes of data:
;   - offset from wTPTBrackets to read trainers
;   - offset from wTPTBrackets to write winner
;   - offset from wTPTBrackets to write loser

TPTWinnersRound1Matches:
    ; ***** WINNERS BRACKET *****
    ; *****     ROUND 1     *****
    ; Match 1 - Game 1
    db TPT_WINNERS_MATCH_1
    db TPT_WINNERS_MATCH_1
    db TPT_LOSERS_MATCH_1_2
    ; Match 2 - Game 2
    db TPT_WINNERS_MATCH_2
    db TPT_WINNERS_MATCH_2
    db TPT_LOSERS_MATCH_2_2
    ; Match 3 - Game 3
    db TPT_WINNERS_MATCH_3
    db TPT_WINNERS_MATCH_3
    db TPT_LOSERS_MATCH_3_2
    ; Match 4 - Game 4
    db TPT_WINNERS_MATCH_4
    db TPT_WINNERS_MATCH_4
    db TPT_LOSERS_MATCH_4_2
    ; Match 5 - Game 5
    db TPT_WINNERS_MATCH_5
    db TPT_WINNERS_MATCH_5
    db TPT_LOSERS_MATCH_5_2
    ; Match 6 - Game 6
    db TPT_WINNERS_MATCH_6
    db TPT_WINNERS_MATCH_6
    db TPT_LOSERS_MATCH_6_2
    ; Match 7 - Game 7
    db TPT_WINNERS_MATCH_7
    db TPT_WINNERS_MATCH_7
    db TPT_LOSERS_MATCH_7_2
    ; Match 8 - Game 8
    db TPT_WINNERS_MATCH_8
    db TPT_WINNERS_MATCH_8
    db TPT_LOSERS_MATCH_8_2
    db -1

TPTWinnersRound2Matches:
    ; ***** WINNERS BRACKET *****
    ; *****     ROUND 2     *****
    ; Match 1 - Game 9
    db TPT_WINNERS_MATCH_1
    db TPT_WINNERS_MATCH_1
    db TPT_LOSERS_MATCH_8
    ; Match 2 - Game 10
    db TPT_WINNERS_MATCH_2
    db TPT_WINNERS_MATCH_1_2
    db TPT_LOSERS_MATCH_7
    ; Match 3 - Game 11
    db TPT_WINNERS_MATCH_3
    db TPT_WINNERS_MATCH_2
    db TPT_LOSERS_MATCH_6
    ; Match 4 - Game 12
    db TPT_WINNERS_MATCH_4
    db TPT_WINNERS_MATCH_2_2
    db TPT_LOSERS_MATCH_5
    ; Match 5 - Game 13
    db TPT_WINNERS_MATCH_5
    db TPT_WINNERS_MATCH_3
    db TPT_LOSERS_MATCH_4
    ; Match 6 - Game 14
    db TPT_WINNERS_MATCH_6
    db TPT_WINNERS_MATCH_3_2
    db TPT_LOSERS_MATCH_3
    ; Match 7 - Game 15
    db TPT_WINNERS_MATCH_7
    db TPT_WINNERS_MATCH_4
    db TPT_LOSERS_MATCH_2
    ; Match 8 - Game 16
    db TPT_WINNERS_MATCH_8
    db TPT_WINNERS_MATCH_4_2
    db TPT_LOSERS_MATCH_1
    db -1

TPTLosersRound1Matches:
    ; *****  LOSERS BRACKET *****
    ; *****     ROUND 1     *****
    ; Match 1 - Game 17
    db TPT_LOSERS_MATCH_1
    db TPT_LOSERS_MATCH_1
    db TPT_ELIMINATED
    ; Match 2 - Game 18
    db TPT_LOSERS_MATCH_2
    db TPT_LOSERS_MATCH_1_2
    db TPT_ELIMINATED
    ; Match 3 - Game 19
    db TPT_LOSERS_MATCH_3
    db TPT_LOSERS_MATCH_2
    db TPT_ELIMINATED
    ; Match 4 - Game 20
    db TPT_LOSERS_MATCH_4
    db TPT_LOSERS_MATCH_2_2
    db TPT_ELIMINATED
    ; Match 5 - Game 21
    db TPT_LOSERS_MATCH_5
    db TPT_LOSERS_MATCH_3
    db TPT_ELIMINATED
    ; Match 6 - Game 22
    db TPT_LOSERS_MATCH_6
    db TPT_LOSERS_MATCH_3_2
    db TPT_ELIMINATED
    ; Match 7 - Game 23
    db TPT_LOSERS_MATCH_7
    db TPT_LOSERS_MATCH_4
    db TPT_ELIMINATED
    ; Match 8 - Game 24
    db TPT_LOSERS_MATCH_8
    db TPT_LOSERS_MATCH_4_2
    db TPT_ELIMINATED
    db -1

TPTWinnersRound3Matches:
    ; ***** WINNERS BRACKET *****
    ; *****     ROUND 3     *****
    ; Match 1 - Game 25
    db TPT_WINNERS_MATCH_1
    db TPT_WINNERS_MATCH_1
    db TPT_LOSERS_MATCH_6_2
    ; Match 2 - Game 26
    db TPT_WINNERS_MATCH_2
    db TPT_WINNERS_MATCH_1_2
    db TPT_LOSERS_MATCH_5_2
    ; Match 3 - Game 27
    db TPT_WINNERS_MATCH_3
    db TPT_WINNERS_MATCH_2
    db TPT_LOSERS_MATCH_8_2
    ; Match 4 - Game 28
    db TPT_WINNERS_MATCH_4
    db TPT_WINNERS_MATCH_2_2
    db TPT_LOSERS_MATCH_7_2
    db -1

TPTLosersRound2Matches:
    ; *****  LOSERS BRACKET *****
    ; *****     ROUND 2     *****
    ; Match 1 - Game 29
    db TPT_LOSERS_MATCH_1
    db TPT_LOSERS_MATCH_5
    db TPT_ELIMINATED
    ; Match 2 - Game 30
    db TPT_LOSERS_MATCH_2
    db TPT_LOSERS_MATCH_6
    db TPT_ELIMINATED
    ; Match 3 - Game 31
    db TPT_LOSERS_MATCH_3
    db TPT_LOSERS_MATCH_7
    db TPT_ELIMINATED
    ; Match 4 - Game 32
    db TPT_LOSERS_MATCH_4
    db TPT_LOSERS_MATCH_8
    db TPT_ELIMINATED
    db -1

TPTLosersRound3Matches:
    ; *****  LOSERS BRACKET *****
    ; *****     ROUND 3     *****
    ; Match 1 - Game 33
    db TPT_LOSERS_MATCH_5
    db TPT_LOSERS_MATCH_1
    db TPT_ELIMINATED
    ; Match 2 - Game 34
    db TPT_LOSERS_MATCH_6
    db TPT_LOSERS_MATCH_1_2
    db TPT_ELIMINATED
    ; Match 3 - Game 35
    db TPT_LOSERS_MATCH_7
    db TPT_LOSERS_MATCH_2
    db TPT_ELIMINATED
    ; Match 4 - Game 36
    db TPT_LOSERS_MATCH_8
    db TPT_LOSERS_MATCH_2_2
    db TPT_ELIMINATED
    db -1

TPTWinnersRound4Matches:
    ; ***** WINNERS BRACKET *****
    ; *****     ROUND 4     *****
    ; Match 1 - Game 37
    db TPT_WINNERS_MATCH_1
    db TPT_WINNERS_MATCH_1
    db TPT_LOSERS_MATCH_4_2
    ; Match 2 - Game 38
    db TPT_WINNERS_MATCH_2
    db TPT_WINNERS_MATCH_1_2
    db TPT_LOSERS_MATCH_3_2
    db -1

TPTLosersRound4Matches:
    ; *****  LOSERS BRACKET *****
    ; *****     ROUND 4     *****
    ; Match 1 - Game 39
    db TPT_LOSERS_MATCH_1
    db TPT_LOSERS_MATCH_3
    db TPT_ELIMINATED
    ; Match 2 - Game 40
    db TPT_LOSERS_MATCH_2
    db TPT_LOSERS_MATCH_4
    db TPT_ELIMINATED
    db -1

TPTLosersRound5Matches:
    ; *****  LOSERS BRACKET *****
    ; *****     ROUND 5     *****
    ; Match 1 - Game 41
    db TPT_LOSERS_MATCH_3
    db TPT_LOSERS_MATCH_1
    db TPT_ELIMINATED
    ; Match 2 - Game 42
    db TPT_LOSERS_MATCH_4
    db TPT_LOSERS_MATCH_1_2
    db TPT_ELIMINATED
    db -1

TPTWinnersRound5Matches:
    ; ***** WINNERS BRACKET *****
    ; *****     ROUND 5     *****
    ; Match 1 - Game 43
    db TPT_WINNERS_MATCH_1
    db TPT_WINNERS_MATCH_1
    db TPT_LOSERS_MATCH_2_2
    db -1

TPTLosersRound6Matches:
    ; *****  LOSERS BRACKET *****
    ; *****     ROUND 6     *****
    ; Match 1 - Game 44
    db TPT_LOSERS_MATCH_1
    db TPT_LOSERS_MATCH_2
    db TPT_ELIMINATED
    db -1

TPTLosersRound7Matches:
    ; *****  LOSERS BRACKET *****
    ; *****     ROUND 7     *****
    ; Match 1 - Game 45
    db TPT_LOSERS_MATCH_2
    db TPT_WINNERS_MATCH_1_2
    db TPT_ELIMINATED
    db -1

TPTWinnersRound6Matches:
    ; ***** WINNERS BRACKET *****
    ; *****     ROUND 6     *****
    ; Match 1 - Game 46
    db TPT_WINNERS_MATCH_1
    db TPT_WINNERS_MATCH_1
    db TPT_LOSERS_MATCH_1   ; TPT_ELIMINATED
    db -1

