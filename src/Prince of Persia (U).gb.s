; md5 80034da43f35307291714ae2553d9ddf

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Prince of Persia (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8b
.DEFINE joypad_2 $ff00+$8c
.DEFINE current_rom_bank $7fff


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $1167
.SECTION "joypad read" SIZE $31 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $8 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Prince of Persia Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $3fff
.SECTION "bank 8" SIZE 1 OVERWRITE
    .DB $8
.ENDS