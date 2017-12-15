; md5 8f160aa0b2f69a019911fd57ac8c5b31

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Beavis and Butt-head (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffe8
.DEFINE joypad_2 $ffe9
.DEFINE current_rom_bank $7fff


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $2097
.BANK $0000 SLOT 0

.ORG $00a9
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
.ORG $0069
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $2978
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $001f SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
