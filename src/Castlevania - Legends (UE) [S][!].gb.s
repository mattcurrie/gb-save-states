; md5 1475824e7262c0d6359f43c287e034a5

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Castlevania - Legends (UE) [S][!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c553
.DEFINE joypad_2 $c555
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $c522


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
.ORG $046c
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $3d00
.SECTION "save/load state" SIZE $300 OVERWRITE
    .DB "--- Castlevania Legends Save Patch ---"
    .INCLUDE "includes/reset_ram.s"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
