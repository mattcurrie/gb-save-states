; md5 916d740fc366ecbf9e5626218e56562d

; ROMBANKS 64
; ROM "Wetrix GB (E) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ffb1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ff8c
DEF joypad_2 EQU $ff8d

SECTION "relocated read from joypad", ROM0[$007e] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$08ca] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$119e] ; length: $0270
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
