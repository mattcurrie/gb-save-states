; md5 ec39462e39e3cbcabe03667fabf12d5a

.INCLUDE "includes/init.s"
.ROMBANKS 128
.BACKGROUND "Sabrina - The Animated Series - Zapped! (U) [C][!].gbc"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE is_cgb 1
.DEFINE current_rom_bank $ff91
.DEFINE uses_mbc5 1


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
.DEFINE original_vblank_handler $084b
.INCLUDE "includes/vblank_handler.s"


;*******************
;* save/load state *
;*******************

.BANK $0000 SLOT 0
.ORG $344c
.SECTION "save/load state" SIZE $02d0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
