; md5 3a4bb57e9fbd4ef563c0c7b59a1c82a5

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Kwirk (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8b
.DEFINE joypad_2 $ff00+$8c
.DEFINE current_rom_bank $015e


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $00c0
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $2b81
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $02 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Kwirk Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
