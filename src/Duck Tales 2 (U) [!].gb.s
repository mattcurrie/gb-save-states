; md5 b4e5876c5acedd12b62e25a12973a4ae

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Duck Tales 2 (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff92
.DEFINE joypad_2 $ff93
.DEFINE current_rom_bank $ff98


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
.ORG $03c1
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $4 SLOT 1
.ORG $3d60
.SECTION "save/load state" SIZE $2a0 OVERWRITE
    .DB "--- Duck Tales 2 Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
