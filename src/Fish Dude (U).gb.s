; md5 0beb67de765ef358d50c28836a39bfb0

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Fish Dude (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ff8a


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0027
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

.DEFINE vblank_handler $0004
.DEFINE original_vblank_handler $04e3
.INCLUDE "includes/vblank_handler.s"


;*******************
;* save/load state *
;*******************

.BANK $0001 SLOT 1
.ORG $3c17
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
