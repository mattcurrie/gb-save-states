; md5 1c94dccdfaaa0c3e1d6bda5969704885

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Qix (JU) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ff8f


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $001c
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;**********
;* joypad *
;**********

.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b

.BANK $0000 SLOT 0
.ORG $2bf8
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $2c28
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $3a8b
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
