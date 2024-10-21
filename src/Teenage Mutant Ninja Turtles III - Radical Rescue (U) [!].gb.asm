; md5 e6104df1feb1318ff1764c791eb4ce0e

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Teenage Mutant Ninja Turtles III - Radical Rescue (U) [!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $c002
.DEFINE set_current_rom_bank 1
.DEFINE do_not_disable_interrupts 1


; joypad
.DEFINE joypad $c033
.DEFINE joypad_2 $c035
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $04cf
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


; save/load state
.BANK $0006 SLOT 1
.ORG $3c03
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"

relocated_read_from_joypad:
    .DB $3E, $20, $E0, $00, $F0, $00, $F0, $00, $2F, $E6, $0F, $47, $3E, $10, $E0, $00
    .DB $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00, $F0, $00
    .DB $2F, $E6, $0F, $CB, $37, $B0, $4F, $FA, $33, $C0, $A9, $A1, $EA, $35, $C0, $EA
    .DB $3C, $C0, $47, $79, $EA, $33, $C0, $EA, $3D, $C0, $3E, $30, $E0, $00

    push bc
    .INCLUDE "includes/joypad_check.asm"
    pop bc
    ret

    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
