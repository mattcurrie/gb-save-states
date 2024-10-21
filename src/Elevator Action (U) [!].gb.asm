; md5 7876945a990ea94ac6b1fe5cf01bc00f

; ROMBANKS 8
; ROM "Elevator Action (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffac
DEF joypad_2 EQU $ffad

; MANUAL EDIT - current rom bank not stored, so assume bank 1 during joypad read routine
DEF current_rom_bank EQU $01a5

;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0e57] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $0e87
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
