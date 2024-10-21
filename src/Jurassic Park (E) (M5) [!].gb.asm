; md5 7173cecc94bcdb7aeb7240ae87491044

; ROMBANKS 16
; ROM "Jurassic Park (E) (M5) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff9c
DEF current_rom_bank EQU $ff91
DEF swap_joypad EQU 1
DEF current_nr34_value EQU $decb


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

DEF RESET_RAM_DONE EQU $01d8
SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$15fc] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4A00], BANK[$0e] ; length: $1000
    DB "--- Jurassic Park Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
