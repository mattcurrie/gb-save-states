; md5 43189b859c0036119f233d46b1f2e9fd

; ROMBANKS 4
; ROM "Bugs Bunny (U) [!].gb"


; config
DEF current_rom_bank EQU $ffcb


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
DEF original_vblank_handler EQU $01a2
INCLUDE "includes/vblank_handler.asm"


; save/load state
SECTION "save/load state", ROMX[$7AED], BANK[$0001] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
