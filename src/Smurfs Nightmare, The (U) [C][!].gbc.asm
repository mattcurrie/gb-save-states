; md5 20052c527795a4f332be14aff49d4d4b

; ROMBANKS 64
; ROM "Smurfs Nightmare, The (U) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $7fff
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $fff5
DEF joypad_2 EQU $fff6

SECTION "relocated read from joypad", ROM0[$3f00] ; length: $40
    DEF interrupts_already_disabled EQU 1
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROMX[$7fe7], BANK[$7] ; length: 14
    ldh a, [$f5]
    xor b
    and b
    ldh [$f6], a
    ld a, b
    ldh [$f5], a
    call relocated_read_from_joypad
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4001], BANK[$0010] ; length: $02e0
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "bank-number-01", ROMX[$7FFF], BANK[$01] ; length: 1
    DB $01
ENDSECTION

SECTION "bank-number-02", ROMX[$7FFF], BANK[$02] ; length: 1
    DB $02
ENDSECTION

SECTION "bank-number-03", ROMX[$7FFF], BANK[$03] ; length: 1
    DB $03
ENDSECTION

SECTION "bank-number-04", ROMX[$7FFF], BANK[$04] ; length: 1
    DB $04
ENDSECTION

SECTION "bank-number-05", ROMX[$7FFF], BANK[$05] ; length: 1
    DB $05
ENDSECTION

SECTION "bank-number-06", ROMX[$7FFF], BANK[$06] ; length: 1
    DB $06
ENDSECTION

SECTION "bank-number-07", ROMX[$7FFF], BANK[$07] ; length: 1
    DB $07
ENDSECTION

SECTION "bank-number-08", ROMX[$7FFF], BANK[$08] ; length: 1
    DB $08
ENDSECTION

SECTION "bank-number-09", ROMX[$7FFF], BANK[$09] ; length: 1
    DB $09
ENDSECTION

SECTION "bank-number-0a", ROMX[$7FFF], BANK[$0a] ; length: 1
    DB $0a
ENDSECTION

SECTION "bank-number-0b", ROMX[$7FFF], BANK[$0b] ; length: 1
    DB $0b
ENDSECTION

SECTION "bank-number-0c", ROMX[$7FFF], BANK[$0c] ; length: 1
    DB $0c
ENDSECTION

SECTION "bank-number-0d", ROMX[$7FFF], BANK[$0d] ; length: 1
    DB $0d
ENDSECTION

SECTION "bank-number-0e", ROMX[$7FFF], BANK[$0e] ; length: 1
    DB $0e
ENDSECTION

SECTION "bank-number-0f", ROMX[$7FFF], BANK[$0f] ; length: 1
    DB $0f
ENDSECTION

SECTION "bank-number-10", ROMX[$7FFF], BANK[$10] ; length: 1
    DB $10
ENDSECTION

SECTION "bank-number-11", ROMX[$7FFF], BANK[$11] ; length: 1
    DB $11
ENDSECTION

SECTION "bank-number-12", ROMX[$7FFF], BANK[$12] ; length: 1
    DB $12
ENDSECTION

SECTION "bank-number-13", ROMX[$7FFF], BANK[$13] ; length: 1
    DB $13
ENDSECTION

SECTION "bank-number-14", ROMX[$7FFF], BANK[$14] ; length: 1
    DB $14
ENDSECTION

SECTION "bank-number-15", ROMX[$7FFF], BANK[$15] ; length: 1
    DB $15
ENDSECTION

SECTION "bank-number-16", ROMX[$7FFF], BANK[$16] ; length: 1
    DB $16
ENDSECTION

SECTION "bank-number-17", ROMX[$7FFF], BANK[$17] ; length: 1
    DB $17
ENDSECTION

SECTION "bank-number-18", ROMX[$7FFF], BANK[$18] ; length: 1
    DB $18
ENDSECTION

SECTION "bank-number-19", ROMX[$7FFF], BANK[$19] ; length: 1
    DB $19
ENDSECTION

SECTION "bank-number-1a", ROMX[$7FFF], BANK[$1a] ; length: 1
    DB $1a
ENDSECTION

SECTION "bank-number-1b", ROMX[$7FFF], BANK[$1b] ; length: 1
    DB $1b
ENDSECTION

SECTION "bank-number-1c", ROMX[$7FFF], BANK[$1c] ; length: 1
    DB $1c
ENDSECTION

SECTION "bank-number-1d", ROMX[$7FFF], BANK[$1d] ; length: 1
    DB $1d
ENDSECTION

SECTION "bank-number-1e", ROMX[$7FFF], BANK[$1e] ; length: 1
    DB $1e
ENDSECTION

SECTION "bank-number-1f", ROMX[$7FFF], BANK[$1f] ; length: 1
    DB $1f
ENDSECTION

SECTION "bank-number-20", ROMX[$7FFF], BANK[$20] ; length: 1
    DB $20
ENDSECTION

SECTION "bank-number-21", ROMX[$7FFF], BANK[$21] ; length: 1
    DB $21
ENDSECTION

SECTION "bank-number-22", ROMX[$7FFF], BANK[$22] ; length: 1
    DB $22
ENDSECTION

SECTION "bank-number-23", ROMX[$7FFF], BANK[$23] ; length: 1
    DB $23
ENDSECTION

SECTION "bank-number-24", ROMX[$7FFF], BANK[$24] ; length: 1
    DB $24
ENDSECTION

SECTION "bank-number-25", ROMX[$7FFF], BANK[$25] ; length: 1
    DB $25
ENDSECTION

SECTION "bank-number-26", ROMX[$7FFF], BANK[$26] ; length: 1
    DB $26
ENDSECTION

SECTION "bank-number-27", ROMX[$7FFF], BANK[$27] ; length: 1
    DB $27
ENDSECTION

SECTION "bank-number-28", ROMX[$7FFF], BANK[$28] ; length: 1
    DB $28
ENDSECTION

SECTION "bank-number-29", ROMX[$7FFF], BANK[$29] ; length: 1
    DB $29
ENDSECTION

SECTION "bank-number-2a", ROMX[$7FFF], BANK[$2a] ; length: 1
    DB $2a
ENDSECTION

SECTION "bank-number-2b", ROMX[$7FFF], BANK[$2b] ; length: 1
    DB $2b
ENDSECTION

SECTION "bank-number-2c", ROMX[$7FFF], BANK[$2c] ; length: 1
    DB $2c
ENDSECTION

SECTION "bank-number-2d", ROMX[$7FFF], BANK[$2d] ; length: 1
    DB $2d
ENDSECTION

SECTION "bank-number-2e", ROMX[$7FFF], BANK[$2e] ; length: 1
    DB $2e
ENDSECTION

SECTION "bank-number-2f", ROMX[$7FFF], BANK[$2f] ; length: 1
    DB $2f
ENDSECTION

SECTION "bank-number-30", ROMX[$7FFF], BANK[$30] ; length: 1
    DB $30
ENDSECTION

SECTION "bank-number-31", ROMX[$7FFF], BANK[$31] ; length: 1
    DB $31
ENDSECTION

SECTION "bank-number-32", ROMX[$7FFF], BANK[$32] ; length: 1
    DB $32
ENDSECTION

SECTION "bank-number-33", ROMX[$7FFF], BANK[$33] ; length: 1
    DB $33
ENDSECTION

SECTION "bank-number-34", ROMX[$7FFF], BANK[$34] ; length: 1
    DB $34
ENDSECTION

SECTION "bank-number-35", ROMX[$7FFF], BANK[$35] ; length: 1
    DB $35
ENDSECTION

SECTION "bank-number-36", ROMX[$7FFF], BANK[$36] ; length: 1
    DB $36
ENDSECTION

SECTION "bank-number-37", ROMX[$7FFF], BANK[$37] ; length: 1
    DB $37
ENDSECTION

SECTION "bank-number-38", ROMX[$7FFF], BANK[$38] ; length: 1
    DB $38
ENDSECTION

SECTION "bank-number-39", ROMX[$7FFF], BANK[$39] ; length: 1
    DB $39
ENDSECTION

SECTION "bank-number-3a", ROMX[$7FFF], BANK[$3a] ; length: 1
    DB $3a
ENDSECTION

SECTION "bank-number-3b", ROMX[$7FFF], BANK[$3b] ; length: 1
    DB $3b
ENDSECTION

SECTION "bank-number-3c", ROMX[$7FFF], BANK[$3c] ; length: 1
    DB $3c
ENDSECTION

SECTION "bank-number-3d", ROMX[$7FFF], BANK[$3d] ; length: 1
    DB $3d
ENDSECTION

SECTION "bank-number-3e", ROMX[$7FFF], BANK[$3e] ; length: 1
    DB $3e
ENDSECTION

SECTION "bank-number-3f", ROMX[$7FFF], BANK[$3f] ; length: 1
    DB $3f
ENDSECTION


; Generated with patch-builder.py
