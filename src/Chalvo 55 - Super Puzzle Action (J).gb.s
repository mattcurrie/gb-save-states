; md5 ba50565630891680c9cf8b1827fca429

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Chalvo 55 - Super Puzzle Action (J).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff9b
.DEFINE joypad_2 $ff9c
.DEFINE current_rom_bank $c9ff
.DEFINE current_nr34_value $cb74

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
.ORG $02f0
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
    .DB "--- Chalvo 55 Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
