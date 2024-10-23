; md5 fb04c5e00adcbf031bd1971e68a6bca5

; ROMBANKS 32
; ROM "Trip World DX.gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ff9b
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff8b
DEF joypad_2 EQU $ff8c

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$26b2] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$6B61], BANK[$0002] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
