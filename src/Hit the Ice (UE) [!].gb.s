; md5 66fc892b9682e8e2981fa83fa681ccad

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Hit the Ice (UE) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c5e9
.DEFINE current_rom_bank $c5a1


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0bfe
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0004 SLOT 1
.ORG $372a
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
