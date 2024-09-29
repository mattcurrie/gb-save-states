; md5 70a9ef90ad443881ca90cdd8d910ae66

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Sagaia (Japan).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c018
.DEFINE joypad_2 $c019
.DEFINE current_rom_bank $c013


;*************************
;* relocated joypad read *
;*************************

.BANK $0000 SLOT 0
.ORG $70
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE   
    .INCLUDE "includes/relocated_read_from_joypad.s"
    ret
.ENDS

;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $1384
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $07 SLOT 1
.ORG $3310
.SECTION "save/load state" SIZE $0255 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
