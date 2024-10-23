; md5 b48161623f12f86fec88320166a21fce

; ROMBANKS 8
; ROM "Super Mario Land (W) (V1.0) [!].gb"


; config
DEF current_rom_bank EQU $0159


; joypad
DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81

SECTION "call relocated read from joypad in other bank", ROM0[$000c] ; length: 26
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION

SECTION "joypad read", ROMX[$481E], BANK[$0003] ; length: 4
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0004] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
