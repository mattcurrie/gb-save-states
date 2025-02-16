; md5 8f6b6ef366a787852f664d945c86eb72

; ROMBANKS 32
; ROM "Adventures of Lolo (U) [S][!].gb"


; config
DEF current_rom_bank EQU $c5fc


; joypad
DEF joypad EQU $c3a1
DEF joypad_2 EQU $c3a2
DEF swap_joypad EQU 1

SECTION "relocated read from joypad", ROM0[$0087] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$06f2] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0010] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
