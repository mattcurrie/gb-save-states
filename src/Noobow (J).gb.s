; md5 ccd0cf7cc240714a9694e1fe296afb7c

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Noobow (J).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8e
.DEFINE current_rom_bank $ffaa


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0475
.SECTION "joypad read" SIZE $28 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $049d
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $10 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Noobow Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
