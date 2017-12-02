; md5 972dc35b3b2bd0762999b1ae48da94f6

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "R-Type (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $d0a0
.DEFINE joypad_2 $d0a1
.DEFINE current_rom_bank $d11a


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/reset_ram.s"
.ENDS


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $39e4
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3c00
.SECTION "save/load state" SIZE $400 OVERWRITE
    .DB "--- R-Type Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
