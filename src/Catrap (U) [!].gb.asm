; md5 5a75fe8de54e4cbd09cae23f050f6965

; ROMBANKS 4
; ROM "Catrap (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8a
DEF joypad_2 EQU $ff8b
DEF current_rom_bank EQU $0005


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$00c1] ; length: $3f
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$021f] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$2] ; length: $4000
    DB "--- Catrap Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
