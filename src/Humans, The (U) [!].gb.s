; md5 4a1ecc8ccc706ed5fdce2fdab2aaf03e

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Humans, The (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $cf88
.DEFINE joypad_2 $cf8a


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $3a78
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
    .DB "--- The Humans Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
