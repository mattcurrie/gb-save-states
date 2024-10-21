; md5 e6104df1feb1318ff1764c791eb4ce0e

; ROMBANKS 8
; ROM "Teenage Mutant Ninja Turtles III - Radical Rescue (U) [!].gb"


; config
DEF current_rom_bank EQU $c002
DEF set_current_rom_bank EQU 1
DEF do_not_disable_interrupts EQU 1


; joypad
DEF joypad EQU $c033
DEF joypad_2 EQU $c035
DEF swap_joypad EQU 1

SECTION "joypad read", ROM0[$04cf] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7C03], BANK[$0006] ; length: $02a0
    DB "--- Save Patch ---"

relocated_read_from_joypad:
    DB $3E, $20, $E0, $00, $F0, $00, $F0, $00, $2F, $E6, $0F, $47, $3E, $10, $E0, $00
    DB $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00
    DB $2F, $E6, $0F, $CB, $37, $B0, $4F, $FA, $33, $C0, $A9, $A1, $EA, $35, $C0, $EA
    DB $3C, $C0, $47, $79, $EA, $33, $C0, $EA, $3D, $C0, $3E, $30, $E0, $00

    push bc
    INCLUDE "includes/joypad_check.asm"
    pop bc
    ret

    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
