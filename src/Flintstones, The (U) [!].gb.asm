; md5 f07ed24e96f84ce78787709f248263c8

; ROMBANKS 32
; ROM "Flintstones, The (U) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ff95


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0085] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* vblank *
;**********

DEF vblank_handler EQU $0062
DEF original_vblank_handler EQU $036f
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
