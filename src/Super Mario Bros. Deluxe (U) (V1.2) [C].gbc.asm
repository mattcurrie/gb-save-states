; md5 b5a71128227f5bc953fd55cb0025807f

; ROMBANKS 64
; ROM "Super Mario Bros. Deluxe (U) (V1.2) [C].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ffbe
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff8b
DEF joypad_2 EQU $ff8c

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$120d] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$79D1], BANK[$0003] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
