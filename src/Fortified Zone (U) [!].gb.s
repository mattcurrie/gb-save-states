; md5 a981378da19c08597db03f3ee02cd6d7

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Fortified Zone (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffd7
.DEFINE joypad_2 $ffd8
.DEFINE current_rom_bank $ffcc


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00c1
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
.ORG $0071
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $0197
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0005 SLOT 1
.ORG $32b1
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
