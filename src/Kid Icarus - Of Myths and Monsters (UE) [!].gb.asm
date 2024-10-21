; md5 23c7be98ac9a4d3b046ad1be3f0965e4

; ROMBANKS 8
; ROM "Kid Icarus - Of Myths and Monsters (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c015
DEF joypad_2 EQU $c016
DEF current_rom_bank EQU $7fff


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    INCLUDE "includes/joypad_read_and_check.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0308] ; length: 3
    jp relocated_read_from_joypad
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D00], BANK[$01] ; length: $2fe
    DB "--- Kid Icarus Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
