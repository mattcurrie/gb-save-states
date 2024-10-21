; md5 bc76c0516129c6791e4087f93f5d3c99

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Battletoads in Ragnarok's World (E) [!].gb"
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
.ORG $2e5e
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $2e91
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0001
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS

.ORG $0000
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $8
.ENDS


; Generated with patch-builder.py
