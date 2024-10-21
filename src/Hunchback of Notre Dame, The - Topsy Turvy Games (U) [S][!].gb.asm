; md5 3f55fde8e05a4d372f7f30a1f7398fb5

; ROMBANKS 32
; ROM "Hunchback of Notre Dame, The - Topsy Turvy Games (U) [S][!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c300
DEF joypad_2 EQU $c301
DEF swap_joypad EQU 1


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a5] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0064] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$12a7] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3d0b] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
