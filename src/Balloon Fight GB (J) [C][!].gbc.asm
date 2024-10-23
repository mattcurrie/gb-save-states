; md5 f94f61e6beaec6222e0d35229e2e271e

; ROMBANKS 16
; ROM "Balloon Fight GB (J) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ffca
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ffa0

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0b72] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$3cd3] ; length: $0300
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
