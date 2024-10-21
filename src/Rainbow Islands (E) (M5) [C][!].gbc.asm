; md5 3c3f9f06b791df796b55ac94f2188ff2

; ROMBANKS 64
; ROM "Rainbow Islands (E) (M5) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $ff89
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $c134
DEF joypad_2 EQU $c135

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0395] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$3d8a] ; length: $0270
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
