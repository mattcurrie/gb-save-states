; md5 d7fb01dec29a52de74e5b335b8619e0a

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Speedball 2 - Brutal Deluxe (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffd2
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $ffd5


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0b89
.BANK $0000 SLOT 0

.ORG $001d
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
.ORG $0e09
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0007 SLOT 1
.ORG $24c2
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
