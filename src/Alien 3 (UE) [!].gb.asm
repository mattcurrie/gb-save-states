; md5 b3f3d35f58a0ea3affc0ec6d4ee1183d

; ROMBANKS 8
; ROM "Alien 3 (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c2bc
DEF joypad_2 EQU $c2bd
DEF current_rom_bank EQU $c2ed
DEF current_nr34_value EQU $c24e


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/reset_ram.asm"
ENDSECTION


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150
SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0277] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C00], BANK[$01] ; length: $400
    DB "--- Alien 3 Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
