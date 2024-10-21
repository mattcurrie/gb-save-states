; md5 ba50565630891680c9cf8b1827fca429

; ROMBANKS 32
; ROM "Chalvo 55 - Super Puzzle Action (J).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff9b
DEF joypad_2 EQU $ff9c
DEF current_rom_bank EQU $c9ff
DEF current_nr34_value EQU $cb74

;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$02f0] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7A00], BANK[$1] ; length: $600
    DB "--- Chalvo 55 Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
