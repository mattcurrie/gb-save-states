; md5 7aa389f71808dc989a38b41009a32851

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Tiny Toon Adventures 2 - Montana's Movie Madness (U) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $7fff


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00eb
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $ff88
.DEFINE joypad_2 $ff89
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $0212
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


; save/load state
.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $3fff
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $8
.ENDS


; Generated with patch-builder.py
