; md5 d9d957771484ef846d4e8d241f6f2815

; ROMBANKS 32
; ROM "Wario Land - Super Mario Land 3 (W) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$80
DEF joypad_2 EQU $ff00+$81
DEF current_rom_bank EQU $a8c5
DEF current_nr34_value EQU $a64e
DEF game_uses_save_ram EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$11f0] ; length: $2f
    ld a,[current_rom_bank]
    push af
    ld a,BANK(relocated_read_from_joypad)
    ld [current_rom_bank],a
    ld [$2100],a
    call relocated_read_from_joypad
    pop af
    ld [current_rom_bank],a
    ld [$2100],a
    jr resume

invoke_joypad_check:
    ld a,[current_rom_bank]
    push af
    ld a,BANK(joypad_check)
    ld [current_rom_bank],a
    ld [$2100],a
    call joypad_check
    pop af
    ld [current_rom_bank],a
    ld [$2100],a
    ret
resume:
ENDSECTION

SECTION "do joypad check", ROM0[$124d] ; length: 3
    jp invoke_joypad_check
ENDSECTION




;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7A00], BANK[$11] ; length: $600
    DB "--- Wario Land Save Patch ---"

relocated_read_from_joypad:
    INCLUDE "includes/joypad_read.asm"
    ret

    INCLUDE "includes/joypad_check.asm"
    ret

    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
