; md5 4d606ab4ffd5c3d3ecf914a6af1c1f90

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Felix the Cat (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c16c
.DEFINE joypad_2 $c16d
.DEFINE current_rom_bank $c5d9


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0979
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $160
.SECTION "save/load state" SIZE $400 OVERWRITE
    .DB "--- Felix The Cat Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
