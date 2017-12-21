; md5 9642b7c599b47135cbd4e45e039d608d

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Amida (J).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $0156


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0025
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;**********
;* vblank *
;**********

.DEFINE vblank_handler $0002
.DEFINE original_vblank_handler $0d44
.INCLUDE "includes/vblank_handler.s"


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
