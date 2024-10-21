; md5 23824d72928a05e9fcf052d42f3c91c6

.INCLUDE "includes/init.asm"
.ROMBANKS 4
.BACKGROUND "Go! Go! Tank (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ff8c


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0085
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

.DEFINE vblank_handler $0062
.DEFINE original_vblank_handler $01d8
.INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $3caf
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
