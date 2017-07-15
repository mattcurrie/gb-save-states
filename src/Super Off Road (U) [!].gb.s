; md5 85d05f95c07ed1b7d787062fe4d2e251

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Super Off Road (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c70b


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
.ORG $2c21
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $3b00
.SECTION "save/load state" SIZE $4fd OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/reset_ram.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
