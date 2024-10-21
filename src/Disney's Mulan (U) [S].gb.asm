; md5 314ca1610e00861bc97611c8f874503a

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Disney's Mulan (U) [S].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00e1
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
.ORG $00a1
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $031b
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0000 SLOT 0
.ORG $0a53
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
