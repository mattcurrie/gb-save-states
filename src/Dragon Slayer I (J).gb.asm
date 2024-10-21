; md5 bc35dc3bf102cfa265c5c7348e674ba9

; ROMBANKS 4
; ROM "Dragon Slayer I (J).gb"


; config
DEF current_rom_bank EQU $0159


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$000c] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; joypad
DEF joypad EQU $ff8c
DEF joypad_2 EQU $ff8b

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$01fa] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0002] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
