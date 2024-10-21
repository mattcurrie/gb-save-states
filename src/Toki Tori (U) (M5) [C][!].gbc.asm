; md5 e1bf59102bcd5e3601f4b24b3e873fd2

; ROMBANKS 64
; ROM "Toki Tori (U) (M5) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $4000
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $c535
DEF joypad_2 EQU $c536

SECTION "joypad read", ROM0[$35ee] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$6EAE], BANK[$0001] ; length: $0315
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
