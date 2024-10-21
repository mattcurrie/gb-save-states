; md5 c4868bf46a993b4c33a9a8af5341282a

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Blaster Master Boy (U).gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ffe1
.DEFINE joypad_2 $ffe2
.DEFINE current_rom_bank $c102


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $03be
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $03ee
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
