; md5 7e4c9c3620bea7b633394beb67e9680b

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Bomberman GB (U) [S][!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ff92


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0159
.BANK $0000 SLOT 0

.ORG $0080
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

.DEFINE vblank_handler $0062
.DEFINE original_vblank_handler $01af
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
