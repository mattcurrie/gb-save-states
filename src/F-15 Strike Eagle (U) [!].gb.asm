; md5 a8b74d14e66f7a3049e79ca147141d52

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "F-15 Strike Eagle (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE current_rom_bank $c8aa


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0027
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

.DEFINE vblank_handler $0004
.DEFINE original_vblank_handler $0339
.INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

.BANK $0003 SLOT 1
.ORG $39f9
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
