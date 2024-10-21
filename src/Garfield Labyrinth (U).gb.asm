; md5 5e441af514d1bcdaec08c133ceea4e5e

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Garfield Labyrinth (U).gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ffd5


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $002f
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;**********
;* vblank *
;**********

.DEFINE vblank_handler $000c
.DEFINE original_vblank_handler $01bb
.INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

.BANK $0003 SLOT 1
.ORG $2e88
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
