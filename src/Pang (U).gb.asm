; md5 031e78c5067b88abe2870841d1125a29

; ROMBANKS 8
; ROM "Pang (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8e
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $ff8d


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0195

SECTION "reset ram", ROM0[$00b7] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0077] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2d9d] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$6DBF], BANK[$0001] ; length: $220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
