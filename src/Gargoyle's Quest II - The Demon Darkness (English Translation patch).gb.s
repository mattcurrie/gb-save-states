; md5 3574c3ae7c83faeb018cb1c05950c25d

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Gargoyle's Quest II - The Demon Darkness (English Translation patch).gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $ffc7


; joypad
.DEFINE joypad $fffa
.DEFINE joypad_2 $fffb

.BANK $0000 SLOT 0
.ORG $2ff8
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $3028
.ENDS


; save/load state
.BANK $0005 SLOT 1
.ORG $32db
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
