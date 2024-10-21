; md5 982ed5d2b12a0377eb14bcdc4123744e

; ROMBANKS 4
; ROM "Tetris (W) (V1.1) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81
DEF current_rom_bank EQU $0087   ; value at this address is EQU $01
DEF current_nr34_value EQU $dfba


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$29a6] ; length: $3c
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$02] ; length: $4000
    DB "--- Tetris Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
