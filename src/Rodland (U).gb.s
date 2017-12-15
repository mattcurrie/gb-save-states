; md5 02a6e150efc50f481042fd542023a550

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Rodland (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c101
.DEFINE joypad_2 $c102
.DEFINE current_rom_bank $c1ce


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $00c8
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0004 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
