; md5 f6c1715b8b93356b8b8ad27f5574dc96

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Beetlejuice (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c939
.DEFINE joypad_2 $c93a
.DEFINE current_rom_bank $7fff


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $3de6
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $3e19
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $3fff
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $8
.ENDS


; Generated with patch-builder.py
