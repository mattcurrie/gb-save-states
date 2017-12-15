; md5 6dfcaebffc8e2645bb2b1e5be69e1514

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Donald Duck in Maui Mallard (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8c
.DEFINE current_rom_bank $4000


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0444
.BANK $0000 SLOT 0

.ORG $00ab
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
.ORG $006b
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $060a
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0001 SLOT 1
.ORG $3724
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
