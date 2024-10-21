; md5 5e441af514d1bcdaec08c133ceea4e5e

; ROMBANKS 8
; ROM "Garfield Labyrinth (U).gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ffd5


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$002f] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* vblank *
;**********

DEF vblank_handler EQU $000c
DEF original_vblank_handler EQU $01bb
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$6E88], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
