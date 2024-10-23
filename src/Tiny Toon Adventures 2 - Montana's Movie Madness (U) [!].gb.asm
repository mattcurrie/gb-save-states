; md5 7aa389f71808dc989a38b41009a32851

; ROMBANKS 16
; ROM "Tiny Toon Adventures 2 - Montana's Movie Madness (U) [!].gb"


; config
DEF current_rom_bank EQU $7fff


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00eb] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; joypad
DEF joypad EQU $ff88
DEF joypad_2 EQU $ff89
DEF swap_joypad EQU 1

SECTION "joypad read", ROM0[$0212] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$7FFF], BANK[$0008] ; length: 1
    DB $8
ENDSECTION


; Generated with patch-builder.py
