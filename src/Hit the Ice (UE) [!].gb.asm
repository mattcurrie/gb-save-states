; md5 66fc892b9682e8e2981fa83fa681ccad

; ROMBANKS 8
; ROM "Hit the Ice (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c5e9
DEF current_rom_bank EQU $c5a1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0bfe] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$772A], BANK[$0004] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
