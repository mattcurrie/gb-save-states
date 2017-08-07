; md5 63e3f5f4b90f17bdf6d2f2aed515e248

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Gargoyle's Quest - Ghosts'n Goblins (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c261
.DEFINE joypad_2 $c262
.DEFINE current_rom_bank $c3c5


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0b31
.SECTION "joypad read" SIZE $30 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $8 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Gargoyle's Quest Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"    
    .INCLUDE "includes/save_state_includes.s"
.ENDS
