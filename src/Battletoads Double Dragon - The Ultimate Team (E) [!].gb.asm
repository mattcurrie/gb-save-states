; md5 ec8dfc2600756d4ff306eedcd03defd2

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Battletoads Double Dragon - The Ultimate Team (E) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ca03
.DEFINE joypad_2 $ca01
.DEFINE current_rom_bank $4000


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $17f2
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $1825
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0009 SLOT 1
.ORG $3965
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
