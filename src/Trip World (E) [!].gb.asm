; md5 c46e059a69d9b3b4b0b9d8d303c559b3

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Trip World (E) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8b
.DEFINE joypad_2 $ff00+$8c
.DEFINE current_rom_bank $ff00+$9b
.DEFINE current_nr34_value $ffd9


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $26b2
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $04 SLOT 1
.ORG $3c00
.SECTION "save/load state" SIZE $400 OVERWRITE
    .DB "--- Trip World Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
