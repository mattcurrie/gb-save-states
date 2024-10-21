; md5 f777a4526089a83ca758efbf01007ec1

; ROMBANKS 8
; ROM "Aero Star (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8e
DEF joypad_2 EQU $ff8f
DEF joypad_3 EQU $ff90
DEF current_rom_bank EQU $ffb6


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$007b] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$02ee] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$67CD], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
