; md5 23c7be98ac9a4d3b046ad1be3f0965e4

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Kid Icarus - Of Myths and Monsters (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c015
.DEFINE joypad_2 $c016
.DEFINE current_rom_bank $7fff


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/joypad_read_and_check.s"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0308
.SECTION "joypad read" SIZE 3 OVERWRITE   
    jp relocated_read_from_joypad
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3d00
.SECTION "save/load state" SIZE $2fe OVERWRITE
    .DB "--- Kid Icarus Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
