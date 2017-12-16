; md5 2bb0df1b672253aaa5f9caf9aab78224

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Final Fantasy Legend II (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff89
.DEFINE current_rom_bank $ff88
.DEFINE game_uses_save_ram 1


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $172e
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $174e
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0001 SLOT 1
.ORG $0343
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
