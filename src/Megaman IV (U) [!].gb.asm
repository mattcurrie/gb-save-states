; md5 8a00f627b8902c92327435901c249e19

; ROMBANKS 32
; ROM "Megaman IV (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $dea1
DEF joypad_2 EQU $dea2
DEF current_rom_bank EQU $df00
DEF current_nr34_value EQU $dc7b


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$3ea8] ; length: $58
    DEF interrupts_already_disabled EQU 1
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "...", ROM0[$0101] ; length: $3
    jp $150
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$179d] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D80], BANK[$01] ; length: $280
    DB "--- Megaman 4 Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
