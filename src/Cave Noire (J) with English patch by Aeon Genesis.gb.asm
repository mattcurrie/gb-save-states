; md5 9cf7725b41ee950f58c33e060718c2cf

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Cave Noire (J) with English patch by Aeon Genesis.gb"
.INCLUDE "includes/header.asm"


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
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


; save/load state
.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
