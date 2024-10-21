; md5 9639948ad274fa15281f549e5f9c4d87

; ROMBANKS 16
; ROM "Metroid II - Return of Samus (W) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$80
DEF joypad_2 EQU $ff00+$81
DEF current_rom_bank EQU $d04e
DEF game_uses_save_ram EQU 1
DEF current_nr34_value EQU $cf1e


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

SECTION "joypad read", ROM0[$22b7] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION

;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C00], BANK[$01] ; length: $400
    DB "--- Metroid II Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
