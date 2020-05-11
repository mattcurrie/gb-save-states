; md5 dd5aa6e85827a3ce6e4b7500e75a3262

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Burai Fighter Deluxe (UE) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $0151


; joypad
.DEFINE joypad $c0e3
.DEFINE joypad_2 $c0e4

.BANK $0000 SLOT 0
.ORG $00e9
.SECTION "call relocated read from joypad in other bank part 1" SIZE 18 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank_part_1.s"
.ENDS

.ORG $0062
.SECTION "call relocated read from joypad in other bank part 2" SIZE 11 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank_part_2.s"
    ret
.ENDS

.BANK $0001 SLOT 1
.ORG $089f
.SECTION "joypad read" SIZE 4 OVERWRITE
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
.ENDS


; save/load state
.BANK $0004 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
