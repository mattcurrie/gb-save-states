; md5 d97f34c22a179fb4094acbc05616f565

; ROMBANKS 16
; ROM "Buster Brothers (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8e
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $ff8d


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$2d79] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $2da1
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
