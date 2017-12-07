; md5 c4801ac17a34635fdce973354e85faef

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Dig Dug (E) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c
.DEFINE current_rom_bank $7fff


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
.ORG $18d9
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $1 SLOT 1
.ORG $3500
.SECTION "save/load state" SIZE $aff OVERWRITE
    .DB "--- Dig Dug Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
