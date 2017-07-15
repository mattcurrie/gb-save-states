; md5 b259feb41811c7e4e1dc200167985c84

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Super Mario Land (W) (V1.1) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$80
.DEFINE joypad_2 $ff00+$81
.DEFINE current_nr34_value $df3a


;*****************************
;* relocated joypad read via *
;*****************************

.BANK $00 SLOT 0
.ORG $000b
.SECTION "relocated read from joypad via" SIZE $14 OVERWRITE
    .INCLUDE "includes/check_for_save_or_load_via_bank_0.s"
.ENDS


;*************************
;* relocated joypad read *
;*************************

.BANK $03 SLOT 1
.ORG $3fb0
.SECTION "relocated read from joypad" SIZE $30 OVERWRITE
    .DEFINE check_for_save_or_load_via_bank_0 1
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS


;*************
;* reset ram *
;*************

.BANK $00 SLOT 0
.ORG $00f1
.SECTION "reset ram" SIZE $f OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.DEFINE RESET_RAM_DONE $0150
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $03 SLOT 1
.ORG $081e
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3dc5
.SECTION "save/load state" SIZE $239 OVERWRITE
; no space    .DB "--- Super Mario Land Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
