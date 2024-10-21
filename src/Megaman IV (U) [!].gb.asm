; md5 8a00f627b8902c92327435901c249e19

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Megaman IV (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $dea1
.DEFINE joypad_2 $dea2
.DEFINE current_rom_bank $df00
.DEFINE current_nr34_value $dc7b


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3ea8
.SECTION "relocated read from joypad" SIZE $58 OVERWRITE
    .DEFINE interrupts_already_disabled 1
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $0101
.SECTION "..." SIZE $3 OVERWRITE
    jp $150  
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $179d
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3d80
.SECTION "save/load state" SIZE $280 OVERWRITE
    .DB "--- Megaman 4 Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
