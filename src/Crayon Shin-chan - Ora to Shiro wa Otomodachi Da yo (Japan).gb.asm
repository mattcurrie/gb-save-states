; md5 a5d383a5f6e9d61b505429257f2c44c1

; ROMBANKS 8
; ROM "Crayon Shin-chan - Ora to Shiro wa Otomodachi Da yo (Japan).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8b
DEF joypad_2 EQU $ff8d
DEF current_rom_bank EQU $ff90


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$3700] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
    ret
ENDSECTION

;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$02e7] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$77A0], BANK[$01] ; length: $0220
    DB "--- XXXXX Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
