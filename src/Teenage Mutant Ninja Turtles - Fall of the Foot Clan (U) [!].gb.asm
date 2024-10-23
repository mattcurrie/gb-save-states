; md5 ad868e84fb6071a3b6a211d16e6cbb66

; ROMBANKS 16
; ROM "Teenage Mutant Ninja Turtles - Fall of the Foot Clan (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c05c
DEF joypad_2 EQU $c010
DEF joypad_3 EQU $c00f
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $c021


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$041a] ; length: $20
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
