; md5 f70c60ca87714fa9d81be60c9ac93de0

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Balloon Kid (W) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$a0
.DEFINE current_rom_bank $ff00+$ca


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $80 OVERWRITE
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
.ORG $0c41
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $07 SLOT 1
.ORG $3d80
.SECTION "save/load state" SIZE $280 OVERWRITE
    .DB "--- Balloon Kid Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
