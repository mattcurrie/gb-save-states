; md5 7876945a990ea94ac6b1fe5cf01bc00f

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Elevator Action (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffac
.DEFINE joypad_2 $ffad

; MANUAL EDIT - current rom bank not stored, so assume bank 1 during joypad read routine
.DEFINE current_rom_bank $01a5

;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0e57
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $0e87
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0004 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
