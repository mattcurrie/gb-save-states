; md5 ed2444afe317452e29c1c2258da6963c

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Adventure Island II (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c
.DEFINE current_rom_bank $4000


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
.ORG $036e
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $1 SLOT 1
.ORG $3a00
.SECTION "save/load state" SIZE $600 OVERWRITE
    .DB "--- Adventure Island II Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
