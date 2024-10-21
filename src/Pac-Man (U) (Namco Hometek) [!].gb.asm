; md5 f6b898bfaa367ac1b0782a363cd098c7

; ROMBANKS 4
; ROM "Pac-Man (U) (Namco Hometek) [!].gb"


; config
DEF current_rom_bank EQU $d600


; reset ram
DEF RESET_RAM_DONE EQU $0867

SECTION "reset ram", ROM0[$00d4] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; vblank
DEF vblank_handler EQU $0004
DEF original_vblank_handler EQU $03bb
INCLUDE "includes/vblank_handler.asm"


; save/load state
SECTION "save/load state", ROM0[$3381] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
