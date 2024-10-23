; md5 27f2c99b13cbdb5a5be4afce87b9039b

; ROMBANKS 16
; ROM "Rolan's Curse II (U) [!].gb"


; config
DEF current_rom_bank EQU $ff8e
DEF game_uses_save_ram EQU 1


;*************
;* reset ram *
;*************
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00c0] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* vblank *
;**********

DEF vblank_handler EQU $0062
DEF original_vblank_handler EQU $039c
DEF original_vblank_handler_pushes EQU 1
MACRO original_vblank_handler_pushes_macro
    db $f5, $c5, $d5, $e5
ENDM
INCLUDE "includes/vblank_handler.asm"


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02c5
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
