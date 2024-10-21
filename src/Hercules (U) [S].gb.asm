; md5 abd4baa57f0b90b402c2e56090394f9e

; ROMBANKS 32
; ROM "Hercules (U) [S].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8a
DEF joypad_2 EQU $ff8b
DEF current_rom_bank EQU $ff8f


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$04bc] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $04ec
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7624], BANK[$0002] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
