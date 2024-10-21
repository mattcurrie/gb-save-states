; md5 119bdf89bdf38e489facd79cf251ccd0

; ROMBANKS 16
; ROM "Super Mario Land DX (v2.0).gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $0159
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81

SECTION "call relocated read from joypad in other bank", ROM0[$3fd0] ; length: 26
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION

SECTION "joypad read", ROMX[$481E], BANK[$0003] ; length: 4
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$6BDA], BANK[$0004] ; length: $0315
    DB "--- Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
