; md5 031e78c5067b88abe2870841d1125a29

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Pang (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8e
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $ff00+$8d


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

.DEFINE RESET_RAM_DONE $0195
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $2d9d
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3a00
.SECTION "save/load state" SIZE $400 OVERWRITE
    .DB "--- Pang Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
