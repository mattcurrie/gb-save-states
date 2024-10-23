; md5 4fd68c1cf8b57e90a5b11b054fc68b46

; ROMBANKS 256
; ROM "Donald Duck - Goin' Quackers (U) (M5) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $0168
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $c46e

SECTION "call relocated read from joypad in other bank", ROM0[$0024] ; length: 26
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION

SECTION "joypad read", ROMX[$41DB], BANK[$0001] ; length: 3
    call invoke_relocated_read_from_joypad_in_other_bank
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7A6D], BANK[$0001] ; length: $02f0
    DB "--- Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
