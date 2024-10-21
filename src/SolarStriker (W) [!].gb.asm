; md5 83bed4ebefeece45748258fd2ef105b3

; ROMBANKS 8
; ROM "SolarStriker (W) [!].gb"


; config
DEF current_rom_bank EQU $4004


; detect current rom bank based on unique values in rom
DEF should_detect_rom_bank EQU 1
MACRO detect_rom_bank
    push bc
    push hl
    ld a, [current_rom_bank]
    ld b, a
    ld c, 1
    ld hl, .bank_values\@
.jump\@
    ld a, [hl+]
    cp b
    jr z, .bank_detected\@
    inc c
    jr .jump\@
.bank_values\@
DB $06, $00, $01
.bank_detected\@
    ld a, c
    pop hl
    pop bc
ENDM


; joypad
DEF joypad EQU $cf80
DEF joypad_2 EQU $cf81

SECTION "joypad read", ROM0[$081a] ; length: $2f
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0004] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
