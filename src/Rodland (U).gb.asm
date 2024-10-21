; md5 02a6e150efc50f481042fd542023a550

; ROMBANKS 8
; ROM "Rodland (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $c101
DEF joypad_2 EQU $c102
DEF current_rom_bank EQU $c1ce


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$00c8] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0004] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
