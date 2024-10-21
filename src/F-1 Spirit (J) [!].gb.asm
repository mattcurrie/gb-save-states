; md5 f7caa11fcb8be738e1fd584ac8aad215

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "F-1 Spirit (J) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c099
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $c0d4


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $09fa
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
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
