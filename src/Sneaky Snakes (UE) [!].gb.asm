; md5 0b5127a54cc8581acfabe0413378ca3d

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Sneaky Snakes (UE) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ffc4


;**********
;* joypad *
;**********

.DEFINE joypad $ff8f
.DEFINE joypad_2 $ff90

.BANK $0000 SLOT 0
.ORG $2ee2
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0003 SLOT 1
.ORG $3639
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
