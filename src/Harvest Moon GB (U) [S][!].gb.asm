; md5 7ef69878c3b5bc5532c69a51a2dd42f3

; ROMBANKS 32
; ROM "Harvest Moon GB (U) [S][!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8c
DEF joypad_2 EQU $ff8b
DEF joypad_3 EQU $ff8a
DEF current_rom_bank EQU $4000
DEF game_uses_save_ram EQU 1


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$00E4] ; length: $1B
    invoke_read:
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$2149] ; length: 4
    call invoke_read
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7A80], BANK[$6] ; length: $580
    DB "--- Harvest Moon Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
