; md5 10d92861e262069ce31559e12b927aa0

; ROMBANKS 16
; ROM "Cave Noire (J).gb"


; config
DEF current_rom_bank EQU $c024
DEF game_uses_save_ram EQU 1


; joypad
DEF joypad EQU $c00e
DEF joypad_2 EQU $c00f
DEF swap_joypad EQU 1

SECTION "joypad read", ROM0[$02a1] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02c5
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
