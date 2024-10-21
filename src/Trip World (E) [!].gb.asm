; md5 c46e059a69d9b3b4b0b9d8d303c559b3

; ROMBANKS 16
; ROM "Trip World (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$8b
DEF joypad_2 EQU $ff00+$8c
DEF current_rom_bank EQU $ff00+$9b
DEF current_nr34_value EQU $ffd9


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$26b2] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C00], BANK[$04] ; length: $400
    DB "--- Trip World Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
