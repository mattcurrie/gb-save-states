; md5 f9445b104ebb70d8fb91c8c64452c0a4

; ROMBANKS 8
; ROM "Wizards & Warriors Chapter X - The Fortress of Fear (E) [!].gb"


; config
DEF current_rom_bank EQU $4000


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00bc] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; vblank
DEF vblank_handler EQU $0004
DEF original_vblank_handler EQU $126a
INCLUDE "includes/vblank_handler.asm"


; save/load state
SECTION "save/load state", ROMX[$4001], BANK[$0004] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$4000], BANK[$0004] ; length: 1
    DB $4
ENDSECTION


; Generated with patch-builder.py
