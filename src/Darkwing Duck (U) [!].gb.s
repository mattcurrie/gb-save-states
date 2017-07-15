; md5 7d776329212fa7cc2b00c5a46f06dd92

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Darkwing Duck (U) [!].gb"
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
.ORG $00C0
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0381
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $08 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Darkwing Duck Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
