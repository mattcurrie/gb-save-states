; md5 1475824e7262c0d6359f43c287e034a5

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Castlevania - Legends (UE) [S][!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c553
.DEFINE joypad_2 $c555
.DEFINE swap_joypad 1


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00eb
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
.ORG $00ab
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $046c
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0000 SLOT 0
.ORG $3996
.SECTION "save/load state" SIZE $220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
