; md5 ed0a8885341ee6a201873b2038c87582

; ROMBANKS 16
; ROM "Itchy & Scratchy - Miniature Golf Madness (U).gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $7fff


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0158

SECTION "reset ram", ROM0[$00ab] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* joypad *
;**********

DEF joypad EQU $ffd2
DEF joypad_2 EQU $ffd3

SECTION "relocated read from joypad", ROM0[$006a] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$03d6] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$7FFF], BANK[$0008] ; length: 1
    DB $8
ENDSECTION


; Generated with patch-builder.py
