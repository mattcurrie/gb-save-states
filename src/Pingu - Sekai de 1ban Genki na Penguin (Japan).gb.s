; md5 4202e3486b95ab9a5718830b2aa9b7f6  

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Pingu - Sekai de 1ban Genki na Penguin (Japan).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffdb
.DEFINE joypad_2 $ffdc
.DEFINE current_rom_bank $fff6
.DEFINE restore_wave_ram 1


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3730
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $078D
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $3770
.SECTION "save/load state" SIZE $240 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
