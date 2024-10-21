; md5 d300bf9412617a95b00b80fa468a8a04

; ROMBANKS 16
; ROM "Alien Olympics 2044 AD (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff9a
DEF current_rom_bank EQU $c009


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$32e7] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $330f
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
