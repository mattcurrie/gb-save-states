; md5 7173cecc94bcdb7aeb7240ae87491044

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Jurassic Park (E) (M5) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff9c
.DEFINE current_rom_bank $ff91
.DEFINE swap_joypad 1
.DEFINE current_nr34_value $decb


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

.DEFINE RESET_RAM_DONE $01d8
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $15fc
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0e SLOT 1
.ORG $0a00
.SECTION "save/load state" SIZE $1000 OVERWRITE
    .DB "--- Jurassic Park Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
