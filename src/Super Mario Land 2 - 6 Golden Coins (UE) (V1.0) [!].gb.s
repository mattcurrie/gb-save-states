; md5 a8413347d5df8c9d14f97f0330d67bce

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Super Mario Land 2 - 6 Golden Coins (UE) (V1.0) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $a24e
.DEFINE game_uses_save_ram 1


; joypad
.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $1fd7
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


; save/load state
.BANK $000d SLOT 1
.ORG $1cdb
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
