; md5 9b846e9a4eb6b80cdbc8e6c82f2b9e9e

; ROMBANKS 64
; ROM "Ghosts 'N Goblins (U) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $7fff
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $c0e0
DEF joypad_2 EQU $c0e1

SECTION "relocated read from joypad", ROM0[$00bf] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$009b] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$5BD9], BANK[$0002] ; length: $0270
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
