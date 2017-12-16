; md5 05ba7f165dab1ffd49b63b4f5c704c02

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Faceball 2000 (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c901
.DEFINE current_rom_bank $ff80


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $09b1
.BANK $0000 SLOT 0

.ORG $0065
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $14bb
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $1db5
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
