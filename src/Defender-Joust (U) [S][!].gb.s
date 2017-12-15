; md5 211a15218fa66e4a09bc253ae064991c

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Defender-Joust (U) [S][!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffbe
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $7fff


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0181
.BANK $0000 SLOT 0

.ORG $00b9
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0079
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $0add
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
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $3fff
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $8
.ENDS


; Generated with patch-builder.py
