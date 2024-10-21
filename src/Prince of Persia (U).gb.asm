; md5 80034da43f35307291714ae2553d9ddf

; ROMBANKS 16
; ROM "Prince of Persia (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8b
DEF joypad_2 EQU $ff8c
DEF current_rom_bank EQU $7fff


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$1167] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$7FFF], BANK[$0008] ; length: 1
    DB $8
ENDSECTION


; Generated with patch-builder.py
