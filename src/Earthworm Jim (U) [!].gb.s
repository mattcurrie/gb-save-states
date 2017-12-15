; md5 0d24eeff28040ff2a8f63de5bc8cbea2

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Earthworm Jim (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c101
.DEFINE joypad_2 $c102
.DEFINE current_rom_bank $7fff


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $00b6
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0010 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $3fff
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $10
.ENDS


; Generated with patch-builder.py
