; md5 bc1a3848092bdc900c157996c29a7783

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Yoshi's Cookie (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8d
.DEFINE joypad_2 $ff8c
.DEFINE joypad_3 $ff8d
.DEFINE current_rom_bank $4000


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0300
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $2 SLOT 1
.ORG $3d00
.SECTION "save/load state" SIZE $300 OVERWRITE
    .DB "--- Yoshi's Cookie Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
