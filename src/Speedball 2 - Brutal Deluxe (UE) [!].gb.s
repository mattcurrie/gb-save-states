; md5 d7fb01dec29a52de74e5b335b8619e0a

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Speedball 2 - Brutal Deluxe (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffd2
.DEFINE current_rom_bank $ffd5
.DEFINE swap_joypad 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0e09
.SECTION "joypad read" SIZE $28 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $7 SLOT 1
.ORG $3c00
.SECTION "save/load state" SIZE $400 OVERWRITE
    .DB "--- Speedball 2 Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
