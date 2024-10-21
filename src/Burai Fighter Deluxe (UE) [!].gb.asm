; md5 dd5aa6e85827a3ce6e4b7500e75a3262

; ROMBANKS 8
; ROM "Burai Fighter Deluxe (UE) [!].gb"


; config
DEF current_rom_bank EQU $0151


; joypad
DEF joypad EQU $c0e3
DEF joypad_2 EQU $c0e4

SECTION "call relocated read from joypad in other bank part 1", ROM0[$00e9] ; length: 18
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank_part_1.asm"
ENDSECTION

SECTION "call relocated read from joypad in other bank part 2", ROM0[$0062] ; length: 11
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank_part_2.asm"
    ret
ENDSECTION

SECTION "joypad read", ROMX[$489F], BANK[$0001] ; length: 4
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
