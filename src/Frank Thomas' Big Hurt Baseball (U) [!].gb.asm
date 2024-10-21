; md5 c5b36de3dd613b23e2aef7fc4427e5f8

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Frank Thomas' Big Hurt Baseball (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c4f4
.DEFINE joypad_2 $c4f5
.DEFINE current_rom_bank $4000


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0472
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $04a5
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0014 SLOT 1
.ORG $18d1
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
