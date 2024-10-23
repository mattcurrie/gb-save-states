; md5 ae073c63ff7d151dc2dd406830fbbdc2

; ROMBANKS 16
; ROM "Batman - The Animated Series (U).gb"


; config
DEF current_rom_bank EQU $ffa3


; joypad
DEF joypad EQU $ffa4
DEF joypad_2 EQU $ffa6
DEF joypad_3 EQU $ffa5
DEF joypad_4 EQU $ffa7
DEF swap_joypad EQU 1

SECTION "joypad read", ROM0[$0843] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $087d
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
