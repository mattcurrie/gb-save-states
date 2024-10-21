; md5 c5b36de3dd613b23e2aef7fc4427e5f8

; ROMBANKS 32
; ROM "Frank Thomas' Big Hurt Baseball (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c4f4
DEF joypad_2 EQU $c4f5
DEF current_rom_bank EQU $4000


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0472] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $04a5
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$58D1], BANK[$0014] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
