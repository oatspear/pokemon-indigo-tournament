SimpleMultiply::
; Return a * c.
	and a
	ret z

	push bc
	ld b, a
	xor a
.loop
	add c
	dec b
	jr nz, .loop
	pop bc
	ret

SimpleDivide::
; Divide a by c. Return quotient b and remainder a.
	ld b, 0
.loop
	inc b
	sub c
	jr nc, .loop
	dec b
	add c
	ret

Multiply::
; Multiply hMultiplicand (3 bytes) by hMultiplier. Result in hProduct.
; All values are big endian.
	push hl
	push bc

	callfar _Multiply

	pop bc
	pop hl
	ret

Divide::
; Divide hDividend length b (max 4 bytes) by hDivisor. Result in hQuotient.
; All values are big endian.
	push hl
	push de
	push bc
	homecall _Divide
	pop bc
	pop de
	pop hl
	ret

MultiplyAndDivide::
; a = $xy: multiply multiplicands by x, then divide by y
; Used for damage modifiers, etc.
	push bc
	ld b, a
	swap a
	and $f
	ld c, LOW(hMultiplier)
	ldh [c], a
	call Multiply
	ld a, b
	and $f
	ldh [c], a
	ld b, 4
	call Divide
	pop bc
	ret
