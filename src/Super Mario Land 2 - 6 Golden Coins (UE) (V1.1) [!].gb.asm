; md5 1d2c316f9f32727261328c7a49b22e2c

; ROMBANKS 32
; ROM "Super Mario Land 2 - 6 Golden Coins (UE) (V1.1) [!].gb"


; config
DEF current_rom_bank EQU $a24e
DEF game_uses_save_ram EQU 1


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$005c] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; joypad
DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81

SECTION "relocated read from joypad", ROM0[$00bd] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2007] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$5CDB], BANK[$000d] ; length: $0245
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
