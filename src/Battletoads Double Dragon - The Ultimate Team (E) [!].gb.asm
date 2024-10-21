; md5 ec8dfc2600756d4ff306eedcd03defd2

; ROMBANKS 16
; ROM "Battletoads Double Dragon - The Ultimate Team (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ca03
DEF joypad_2 EQU $ca01
DEF current_rom_bank EQU $4000


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$17f2] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $1825
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7965], BANK[$0009] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
