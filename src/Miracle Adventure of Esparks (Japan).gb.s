; md5 64080619789f154ee057f2946a98c61c

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Miracle Adventure of Esparks (Japan).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $fffa
.DEFINE joypad_2 $fffb
.DEFINE current_rom_bank $ffc7

;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $5
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $08 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $0255 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
	.INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
