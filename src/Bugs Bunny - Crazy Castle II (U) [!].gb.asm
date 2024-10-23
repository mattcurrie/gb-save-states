; md5 8963803e642dbfbe4f5f3bc5a567785d

; ROMBANKS 8
; ROM "Bugs Bunny - Crazy Castle II (U) [!].gb"


; config
DEF current_rom_bank EQU $ffd6


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00c4] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; vblank
DEF vblank_handler EQU $000c
DEF original_vblank_handler EQU $01b0
INCLUDE "includes/vblank_handler.asm"


; save/load state
SECTION "save/load state", ROMX[$7CF4], BANK[$0001] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
