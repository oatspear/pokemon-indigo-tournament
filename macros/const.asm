; Enumerate constants

MACRO const_def
if _NARG >= 1
const_value = \1
else
const_value = 0
endc
if _NARG >= 2
const_inc = \2
else
const_inc = 1
endc
ENDM

MACRO const
\1 EQU const_value
const_value = const_value + const_inc
ENDM

MACRO shift_const
\1 EQU (1 << const_value)
const_value = const_value + const_inc
ENDM

MACRO const_skip
if _NARG >= 1
const_value = const_value + const_inc * (\1)
else
const_value = const_value + const_inc
endc
ENDM

MACRO const_next
if (const_value > 0 && \1 < const_value) || (const_value < 0 && \1 > const_value)
fail "const_next cannot go backwards from {const_value} to \1"
else
const_value = \1
endc
ENDM
