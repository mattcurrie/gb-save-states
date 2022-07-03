; md5 ae073c63ff7d151dc2dd406830fbbdc2

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Batman - The Animated Series (U).gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $ffa3


; joypad
.DEFINE joypad $ffa4
.DEFINE joypad_2 $ffa6
.DEFINE joypad_3 $ffa5
.DEFINE joypad_4 $ffa7
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $0843
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $087d
.ENDS


; save/load state
.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
