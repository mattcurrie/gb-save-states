; md5 b7598a51e0acc0d74ca8f464826371ed

; ROMBANKS 128
; ROM "Wario Land II (U) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ffa4
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1
DEF current_sram_bank EQU $ffa3
DEF current_nr34_value EQU $cf63


; joypad
DEF joypad EQU $c60b
DEF joypad_2 EQU $c60c

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$1a9d] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$33de] ; length: $0300
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
