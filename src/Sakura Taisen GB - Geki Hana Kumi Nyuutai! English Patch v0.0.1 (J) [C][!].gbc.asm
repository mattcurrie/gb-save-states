; md5 ce604c67bf2806f5a6f736ba168ed271

; ROMBANKS 256
; ROM "Sakura Taisen GB - Geki Hana Kumi Nyuutai! English Patch v0.0.1 (J) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $c292
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $c215

SECTION "relocated read from joypad", ROM0[$0064] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$03d1] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$3300] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; fix for write to SRAM bank selection register at $08:$5f33
SECTION "fix", ROMX[$5F33], BANK[$0008] ; length: $1
    dec hl
ENDSECTION

; Generated with patch-builder.py
