; md5 57726c28dc09949029a154f63b891dd0

; ROMBANKS 16
; ROM "Addams Family, The - Pugsley's Scavenger Hunt (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff9a
DEF current_rom_bank EQU $c144


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0158

SECTION "reset ram", ROM0[$00cf] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$08c1] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $08e9
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
