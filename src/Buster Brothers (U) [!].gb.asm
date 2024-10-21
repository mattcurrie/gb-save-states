; md5 d97f34c22a179fb4094acbc05616f565

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Buster Brothers (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff8e
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $ff8d


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $2d79
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $2da1
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
