; pokecrystal requires rgbds 0.6.0 or newer.
MAJOR EQU 0
MINOR EQU 6
PATCH EQU 0

WRONG_RGBDS EQUS "fail \"pokecrystal requires rgbds v0.6.0 or newer.\""

IF !DEF(__RGBDS_MAJOR__) || !DEF(__RGBDS_MINOR__) || !DEF(__RGBDS_PATCH__)
	WRONG_RGBDS
ELSE
IF (__RGBDS_MAJOR__ < MAJOR) || \
	(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ < MINOR) || \
	(__RGBDS_MAJOR__ == MAJOR && __RGBDS_MINOR__ == MINOR && __RGBDS_PATCH__ == PATCH && DEF(__RGBDS_RC__))
	WRONG_RGBDS
ENDC
ENDC
