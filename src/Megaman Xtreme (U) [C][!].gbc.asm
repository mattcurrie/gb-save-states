; md5 4681f5b931a2e60ca163facd1adf56ed

; ROMBANKS 64
; ROM "Megaman Xtreme (U) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $7ffe
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff8f
DEF joypad_2 EQU $ff90
DEF preserve_registers EQU 1

SECTION "relocated read from joypad", ROM0[$0087] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0911] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7D3F], BANK[$0002] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
