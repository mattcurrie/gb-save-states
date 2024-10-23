; md5 1f64989765f605d05cbd013e7ffcc352

; ROMBANKS 64
; ROM "Megaman Xtreme 2 (U) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ff92
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff8f
DEF joypad_2 EQU $ff90

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$062a] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7D00], BANK[$0001] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
