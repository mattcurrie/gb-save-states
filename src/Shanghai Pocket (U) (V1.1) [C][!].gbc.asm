; md5 f7e13de010decf104efa3db865971f34

; ROMBANKS 64
; ROM "Shanghai Pocket (U) (V1.1) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $d414
DEF uses_mbc5 EQU 1
DEF preserve_registers EQU 1
DEF swap_joypad EQU 1


; joypad
DEF joypad EQU $c0a4

SECTION "relocated read from joypad", ROM0[$00bf] ; length: $003f
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$3ad2] ; length: 8
    ld [joypad], a
    call relocated_read_from_joypad
    nop
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$6F81], BANK[$0001] ; length: $0270
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
