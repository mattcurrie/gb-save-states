; md5 f7caa11fcb8be738e1fd584ac8aad215

; ROMBANKS 16
; ROM "F-1 Spirit (J) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c099
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $c0d4


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$09fa] ; length: $20
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
