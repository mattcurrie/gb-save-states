; md5 ba760b6d4b96baf0fa2e7ad6e4498a95

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Nemesis II - The Return of the Hero (E) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $c7a4


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00cf
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $c78e
.DEFINE joypad_2 $c78f
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $0ca8
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


; save/load state
.BANK $0002 SLOT 1
.ORG $3a21
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
