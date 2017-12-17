; md5 abd4baa57f0b90b402c2e56090394f9e

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Hercules (U) [S].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b
.DEFINE current_rom_bank $ff8f


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $04bc
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $04ec
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $3624
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
