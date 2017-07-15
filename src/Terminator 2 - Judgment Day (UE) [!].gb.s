; md5 133ae23114bf442fef6acccd1b8e187a

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Terminator 2 - Judgment Day (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $d093
.DEFINE joypad_2 $d094
.DEFINE current_rom_bank $d104


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "reset ram" SIZE $70 OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $236
.SECTION "joypad read" SIZE $30 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $02 SLOT 1
.ORG $3d00
.SECTION "save/load state" SIZE $300 OVERWRITE
    .DB "--- Terminator 2 Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
