; md5 8b7af1a8ca96c74301d633e0ce83ba0b

; ROMBANKS 32
; ROM "Legend of Zelda, The - Link's Awakening (G) [!].gb"


; config
DEF current_rom_bank EQU $dbaf
DEF game_uses_save_ram EQU 1


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0006] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$101] ; length: SIZE
    jp RESET_RAM
ENDSECTION


; joypad
DEF joypad EQU $ffcb
DEF joypad_2 EQU $ffcc
DEF swap_joypad EQU 1

SECTION "relocated read from joypad", ROM0[$0092] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2838] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$6e2a], BANK[$0009] ; length: $0245
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
