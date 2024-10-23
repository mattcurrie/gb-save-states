; md5 24a6b4457a511cc667e9ac25417401ab

; ROMBANKS 16
; ROM "Kid Dracula (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c9c6
DEF joypad_2 EQU $c9c7
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $7fff
DEF current_nr34_value EQU $c7ed


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$3f00] ; length: $d0
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0537] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D00], BANK[$03] ; length: $2fe
    DB "--- Kid Dracula Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
