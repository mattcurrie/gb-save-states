; md5 a8b74d14e66f7a3049e79ca147141d52

; ROMBANKS 8
; ROM "F-15 Strike Eagle (U) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $c8aa


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
DEF original_vblank_handler EQU $0339
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$79F9], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
