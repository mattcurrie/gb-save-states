; md5 f28ade3926852a8ad2e449c274683956

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Mole Mania (U) [S][!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b
.DEFINE current_rom_bank $ff8c
.DEFINE game_uses_save_ram 1
.DEFINE restore_wave_ram 1


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $00a0
.SECTION "relocated read from joypad" SIZE $60 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/reset_ram.s"
.ENDS


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $01e2
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $02 SLOT 1
.ORG $3a00
.SECTION "save/load state" SIZE $600 OVERWRITE
    .DB "--- Mole Mania Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
