; md5 9c1efb1bd07fd91765f680e7e9bc44f1

; ROMBANKS 16
; ROM "Hudson Hawk (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $de04
DEF joypad_2 EQU $de07
DEF joypad_3 EQU $de06
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $de0c


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$38d4] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $3911
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
