; md5 159c8ca77e153b1cc5fe6d5d82a091c2

; ROMBANKS 8
; ROM "Barbie - Game Girl (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8c
DEF current_rom_bank EQU $4000


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $037e

SECTION "reset ram", ROM0[$00ab] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$006b] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$04e6] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C11], BANK[$0005] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
