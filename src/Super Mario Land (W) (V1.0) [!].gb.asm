; md5 b48161623f12f86fec88320166a21fce

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Super Mario Land (W) (V1.0) [!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $0159


; joypad
.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $000c
.SECTION "call relocated read from joypad in other bank" SIZE 26 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS

.BANK $0003 SLOT 1
.ORG $081e
.SECTION "joypad read" SIZE 4 OVERWRITE
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
.ENDS


; save/load state
.BANK $0004 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
