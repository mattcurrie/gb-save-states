; md5 9c1efb1bd07fd91765f680e7e9bc44f1

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Hudson Hawk (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $de04
.DEFINE joypad_2 $de07
.DEFINE joypad_3 $de06
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $de0c


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $38d4
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $3911
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
