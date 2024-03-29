; md5 298c80fe568bb2ff8bb7e4dfe5862a9d

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Probotector (E) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $7fff


; reset ram 
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00e6
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $dee6
.DEFINE joypad_2 $dee7
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $16be
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
