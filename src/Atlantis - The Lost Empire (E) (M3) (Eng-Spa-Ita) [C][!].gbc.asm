; md5 e24141ed6fc94b149bbf43b4bd9658e8

; ROMBANKS 128
; ROM "Atlantis - The Lost Empire (E) (M3) (Eng-Spa-Ita) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $7fff
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $c10a
DEF joypad_2 EQU $c10b

SECTION "joypad read", ROM0[$00b8] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$3907] ; length: $02f0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
