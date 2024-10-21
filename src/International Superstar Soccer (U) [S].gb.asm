; md5 bf4e4002ffa88b9be2c8b8a5b4cd9a48

; ROMBANKS 16
; ROM "International Superstar Soccer (U) [S].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $c002


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00cb] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* vblank *
;**********

DEF vblank_handler EQU $00a8
DEF original_vblank_handler EQU $0068
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$2bd2] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
