; md5 785441d3d75913393807b10b3194dc48

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Duck Tales (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c
.DEFINE current_rom_bank $ff93


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $3791
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $4 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Duck Tales Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
