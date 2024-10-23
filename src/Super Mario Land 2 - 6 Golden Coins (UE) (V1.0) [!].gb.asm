; md5 a8413347d5df8c9d14f97f0330d67bce

; ROMBANKS 32
; ROM "Super Mario Land 2 - 6 Golden Coins (UE) (V1.0) [!].gb"


; config
DEF current_rom_bank EQU $a24e
DEF game_uses_save_ram EQU 1


; joypad
DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81

SECTION "joypad read", ROM0[$1fd7] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$5CDB], BANK[$000d] ; length: $02c5
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
