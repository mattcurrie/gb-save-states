; md5 2a2ae531b2cebd995508707b0e82b1b1

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "B.C. Kid 2 (E) [S].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c860
.DEFINE joypad_2 $c861
.DEFINE current_rom_bank $c865
.DEFINE current_nr34_value $dc2a


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $18d4
.SECTION "joypad read" SIZE $50 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $10 SLOT 1
.ORG $0

.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- B.C. Kid 2 Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
