; md5 16bb3fb83e8cbbf2c4c510b9f50cf4ee

; ROMBANKS 128
; ROM "Wario Land 3 (JU) (M2) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $c5ff
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1
DEF current_sram_bank EQU $c08e


; joypad
DEF joypad EQU $c093
DEF joypad_2 EQU $c094

SECTION "relocated read from joypad", ROM0[$009b] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0413] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$1c6d] ; length: $02bd
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
