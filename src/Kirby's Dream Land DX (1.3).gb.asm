; md5 e6af05e6e73a6f0b025f43d8f36fc1e4

; ROMBANKS 16
; ROM "Kirby's Dream Land DX (1.3).gb"


;**********
;* config *
;**********

DEF is_cgb EQU 1
DEF joypad EQU $d04f
DEF joypad_2 EQU $ff00+$8b
DEF current_rom_bank EQU $CF99
DEF current_nr34_value EQU $de14


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$06e7] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*********************************
;* remap title screen key combos *
;*********************************

SECTION "configuration mode", ROMX[$4083], BANK[$06] ; length: 1
    DB $82  ; use "down + b" instead of "select + down + b"
ENDSECTION
SECTION "extra game", ROMX[$4088], BANK[$06] ; length: 1
    DB $41  ; use "up + a" instead of "select + up + a"
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D00], BANK[$0f] ; length: $2e0
    DB "--- Kirby's Dream Land Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
