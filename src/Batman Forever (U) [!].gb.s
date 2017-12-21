; md5 28737a5c760938a9746fa9e1a2fcefc6

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Batman Forever (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $d89d


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0068
.BANK $0000 SLOT 0

.ORG $00d7
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

.DEFINE vblank_handler $00b4
.DEFINE original_vblank_handler $06a6
.INCLUDE "includes/vblank_handler.s"


;*******************
;* save/load state *
;*******************

.BANK $0010 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
