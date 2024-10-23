; md5 4ca44cbdd4e05c9b3c22da96d3de6338

; ROMBANKS 128
; ROM "Legend of Zelda, The - Oracle of Seasons (E) (M5) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $7fff
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; vblank
DEF vblank_handler EQU $3ef3
DEF original_vblank_handler EQU $09f6
DEF original_vblank_handler_pushes EQU 1
MACRO original_vblank_handler_pushes_macro
    db $f5, $c5, $d5, $e5
ENDM
INCLUDE "includes/vblank_handler.asm"


; save/load state
SECTION "save/load state", ROMX[$4001], BANK[$0033] ; length: $0315
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
