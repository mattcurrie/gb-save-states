; md5 28737a5c760938a9746fa9e1a2fcefc6

; ROMBANKS 32
; ROM "Batman Forever (U) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $d89d


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0068

SECTION "reset ram", ROM0[$00d7] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* vblank *
;**********

DEF vblank_handler EQU $00b4
DEF original_vblank_handler EQU $06a6
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0010] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
