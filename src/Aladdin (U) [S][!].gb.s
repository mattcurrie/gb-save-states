; md5 ed5525a71dda6eaf4bbf8d5601b6b3b9

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Aladdin (U) [S][!].gb" 
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c280
.DEFINE current_rom_bank $ddfa


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0061
.SECTION "relocated read from joypad" SIZE $80 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
    ret
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $04ae
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $10 SLOT 1
.ORG 0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Aladdin Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
