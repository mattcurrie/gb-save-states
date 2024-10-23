; md5 3574c3ae7c83faeb018cb1c05950c25d

; ROMBANKS 16
; ROM "Gargoyle's Quest II - The Demon Darkness (English Translation patch).gb"


; config
DEF current_rom_bank EQU $ffc7


; joypad
DEF joypad EQU $fffa
DEF joypad_2 EQU $fffb

SECTION "joypad read", ROM0[$2ff8] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $3028
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$72DB], BANK[$0005] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
