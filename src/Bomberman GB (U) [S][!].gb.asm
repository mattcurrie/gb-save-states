; md5 7e4c9c3620bea7b633394beb67e9680b

; ROMBANKS 32
; ROM "Bomberman GB (U) [S][!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ff92


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0159

SECTION "reset ram", ROM0[$0080] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* vblank *
;**********

DEF vblank_handler EQU $0062
DEF original_vblank_handler EQU $01af
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
