; md5 84ff06249f96442626cdd75a5fa440ce

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Animaniacs (U) [S][!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ff94


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0024
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

.DEFINE vblank_handler $0001
.DEFINE original_vblank_handler $0ede
.INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

.BANK $0010 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
