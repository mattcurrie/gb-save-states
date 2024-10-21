; md5 506ccd75db221acbf26f1681f3c97efd

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Amazing Spider-Man 2, The (UE) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ffb2
.DEFINE joypad_2 $d096
.DEFINE current_rom_bank $d0e4


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $02b4
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
