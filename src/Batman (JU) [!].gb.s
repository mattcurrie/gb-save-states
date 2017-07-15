; md5 03c6d84a951be6703b7458478f4277b9

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Batman (JU) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$b4
.DEFINE joypad_2 $ff00+$b5


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0d28
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $3d00
.SECTION "save/load state" SIZE $300 OVERWRITE
    .DB "--- Batman Save Patch v1.0 ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
