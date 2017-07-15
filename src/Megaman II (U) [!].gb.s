; md5 7fe07271d04ed9e0bc0663dde55a2ae4

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Megaman II (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8e


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0395
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
    .DB "--- Megaman 2 Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
