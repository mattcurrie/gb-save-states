; md5 63e3f5f4b90f17bdf6d2f2aed515e248

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Gargoyle's Quest - Ghosts'n Goblins (UE) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c261
.DEFINE joypad_2 $c262
.DEFINE current_rom_bank $c3c5


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0b31
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
