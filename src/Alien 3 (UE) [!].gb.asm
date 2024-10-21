; md5 b3f3d35f58a0ea3affc0ec6d4ee1183d

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Alien 3 (UE) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c2bc
.DEFINE joypad_2 $c2bd
.DEFINE current_rom_bank $c2ed
.DEFINE current_nr34_value $c24e


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
    .INCLUDE "includes/reset_ram.asm"
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
.ORG $0277
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
    .DB "--- Alien 3 Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
