; md5 c4639cc61c049e5a085526bb6cac03bb

; ROMBANKS 64
; ROM "Legend of Zelda, The - Oracle of Ages (U) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ff97
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $c481
DEF joypad_2 EQU $c480
DEF joypad_3 EQU $c482

SECTION "relocated read from joypad", ROM0[$3ef8] ; length: $003b
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0290] ; length: 3
    call relocated_read_from_joypad
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7A32], BANK[$0006] ; length: $0315
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
