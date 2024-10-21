; md5 79d6e6515905ec3fbcbd9e50ff469000

; ROMBANKS 16
; ROM "Bonk's Adventure (U) [!].gb"


; config
DEF current_rom_bank EQU $c148


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0024] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; joypad
DEF joypad EQU $ff8d
DEF joypad_2 EQU $ff8e

SECTION "relocated read from joypad", ROM0[$0071] ; length: $0038
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0592] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7B91], BANK[$0001] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
