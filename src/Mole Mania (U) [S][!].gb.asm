; md5 f28ade3926852a8ad2e449c274683956

; ROMBANKS 32
; ROM "Mole Mania (U) [S][!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8a
DEF joypad_2 EQU $ff8b
DEF current_rom_bank EQU $ff8c
DEF game_uses_save_ram EQU 1
DEF restore_wave_ram EQU 1


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$00a0] ; length: $60
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

SECTION "joypad read", ROM0[$01e2] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7A00], BANK[$02] ; length: $600
    DB "--- Mole Mania Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
