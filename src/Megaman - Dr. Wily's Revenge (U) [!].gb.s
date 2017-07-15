; md5 4ba4398181d98958fa7434ba7716f11a

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Megaman - Dr. Wily's Revenge (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8a
.DEFINE joypad_2 $ff00+$8b


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $15b2
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
    .DB "--- Megaman Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
