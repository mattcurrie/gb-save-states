; md5 10d92861e262069ce31559e12b927aa0

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Cave Noire (J).gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $c024
.DEFINE game_uses_save_ram 1


; joypad
.DEFINE joypad $c00e
.DEFINE joypad_2 $c00f
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $02a1
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


; save/load state
.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
