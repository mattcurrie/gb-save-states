; md5 ec39462e39e3cbcabe03667fabf12d5a

; ROMBANKS 128
; ROM "Sabrina - The Animated Series - Zapped! (U) [C][!].gbc"


;**********
;* config *
;**********

DEF is_cgb EQU 1
DEF current_rom_bank EQU $ff91
DEF uses_mbc5 EQU 1


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
DEF original_vblank_handler EQU $084b
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$344c] ; length: $02d0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
