; md5 ab5f50d0e31a07e19739453bb9a2d328

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Dick Tracy (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c
.DEFINE current_rom_bank $4000


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $000c
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
.ORG $13c7
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0001
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $0000
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $8
.ENDS


; Generated with patch-builder.py
