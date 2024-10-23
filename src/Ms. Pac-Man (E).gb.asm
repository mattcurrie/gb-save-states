; md5 5cfa323ad8d8e4a6d50022d5c64b46fd

; ROMBANKS 4
; ROM "Ms. Pac-Man (E).gb"


; config
DEF current_rom_bank EQU $4000


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a3] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; joypad
DEF joypad EQU $ff8b
DEF joypad_2 EQU $ff8c

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$03ea] ; length: 5
    call relocated_read_from_joypad
    nop
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7070], BANK[$0001] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
