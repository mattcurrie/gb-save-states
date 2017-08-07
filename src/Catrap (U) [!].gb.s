; md5 5a75fe8de54e4cbd09cae23f050f6965

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Catrap (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b
.DEFINE current_rom_bank $0005


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $00c1
.SECTION "relocated read from joypad" SIZE $3f OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $021f
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $2 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Catrap Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
