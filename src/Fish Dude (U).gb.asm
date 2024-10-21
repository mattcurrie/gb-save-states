; md5 0beb67de765ef358d50c28836a39bfb0

; ROMBANKS 4
; ROM "Fish Dude (U).gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ff8a


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0027] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* vblank *
;**********

DEF vblank_handler EQU $0004
DEF original_vblank_handler EQU $04e3
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C17], BANK[$0001] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
