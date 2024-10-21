; md5 c4801ac17a34635fdce973354e85faef

; ROMBANKS 8
; ROM "Dig Dug (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8b
DEF joypad_2 EQU $ff8c
DEF current_rom_bank EQU $7fff


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0061] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0000] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$18d9] ; length: 5
    call relocated_read_from_joypad
    nop
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$741F], BANK[$0001] ; length: $220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
