; md5 506ccd75db221acbf26f1681f3c97efd

; ROMBANKS 16
; ROM "Amazing Spider-Man 2, The (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffb2
DEF joypad_2 EQU $d096
DEF current_rom_bank EQU $d0e4


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$02b4] ; length: $20
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
