; md5 63e3f5f4b90f17bdf6d2f2aed515e248

; ROMBANKS 16
; ROM "Gargoyle's Quest - Ghosts'n Goblins (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c261
DEF joypad_2 EQU $c262
DEF current_rom_bank EQU $c3c5


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0b31] ; length: $20
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


; Generated with patch-builder.py
