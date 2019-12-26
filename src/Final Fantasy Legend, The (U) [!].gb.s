; md5 d5c27ff8cb1b69cb56df4ff170e2baf0

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Final Fantasy Legend, The (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ff8b
.DEFINE game_uses_save_ram 1


;**********
;* joypad *
;**********

.DEFINE joypad $ff8d

.BANK $0000 SLOT 0
.ORG $06f7
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $0717
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
