; md5 bdcf042bc2458768522c3cca43c89ee1

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Days of Thunder (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $d541
.DEFINE joypad_2 $d543
.DEFINE current_rom_bank $ffef


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00a4
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0063
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $0e09
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
