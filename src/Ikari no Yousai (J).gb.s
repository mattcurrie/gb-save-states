; md5 ac04d143de6734e181a223d05178bde8

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Ikari no Yousai (J).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $ffcc


;**********
;* joypad *
;**********

.DEFINE joypad $ffd7
.DEFINE joypad_2 $ffd8

.BANK $0000 SLOT 0
.ORG $015b
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $019b
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $3c2a
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
