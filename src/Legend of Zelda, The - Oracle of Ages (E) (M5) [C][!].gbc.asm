; md5 825de040ea4dff66661693f8712b1bdb

; ROMBANKS 128
; ROM "Legend of Zelda, The - Oracle of Ages (E) (M5) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ffd8
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
SECTION "save/load state", ROMX[$7000], BANK[$0001] ; length: $0315
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
