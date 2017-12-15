; md5 9d94d01d3133165d4469bb27d58f0f6c

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Bill & Ted's Excellent Gameboy Adventure (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8e
.DEFINE joypad_2 $ff8f


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0070
.BANK $0000 SLOT 0

.ORG $0028
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
.ORG $02aa
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $02db
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0000 SLOT 0
.ORG $3ce1
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
