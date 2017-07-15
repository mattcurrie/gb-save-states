; md5 ad868e84fb6071a3b6a211d16e6cbb66

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Teenage Mutant Ninja Turtles - Fall of the Foot Clan (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c05c
.DEFINE joypad_2 $c010
.DEFINE joypad_3 $c00f
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $c021


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $041a
.SECTION "joypad read" SIZE $30 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $08 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- TMNT - Fall of the Foot Clan Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
