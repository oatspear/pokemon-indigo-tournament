GetCrystalCGBLayout:
	ld a, b
	cp SCGB_DEFAULT
	jr nz, .not_default
	ld a, [wDefaultSGBLayout]
.not_default
	push af
	farcall ResetBGPals
	pop af
	ld l, a
	ld h, 0
	add hl, hl
	ld de, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .done
	push de
	jp hl
.done:
	ret

.Jumptable:
	dw _CrystalCGB_NameCard

Crystal_FillBoxCGB:
; This is a copy of FillBoxCGB.
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

Crystal_WipeAttrmap:
; This is a copy of WipeAttrmap.
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	xor a
	call ByteFill
	ret

LoadOW_BGPal7::
	ld hl, Palette_TextBG7
	ld de, wBGPals1 palette PAL_BG_TEXT
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	ret

Palette_TextBG7:
INCLUDE "gfx/font/bg_text.pal"

INCLUDE "engine/tilesets/tileset_palettes.asm"

_CrystalCGB_NameCard:
	ld hl, .BGPalette
	ld de, wBGPals1
	ld bc, 1 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	farcall ApplyPals
	call Crystal_WipeAttrmap
	farcall ApplyAttrmap
	ld hl, .OBPalette
	ld de, wOBPals1
	ld bc, 1 palettes
	ld a, BANK(wOBPals1)
	call FarCopyWRAM
	ret

.BGPalette:
INCLUDE "gfx/mystery_gift/name_card_bg.pal"

.OBPalette:
INCLUDE "gfx/mystery_gift/name_card_ob.pal"

_LoadTradeRoomBGPals:
	ld hl, TradeRoomPalette
	ld de, wBGPals1 palette PAL_BG_GREEN
	ld bc, 6 palettes
	ld a, BANK(wBGPals1)
	call FarCopyWRAM
	farcall ApplyPals
	ret

TradeRoomPalette:
INCLUDE "gfx/trade/border.pal"
