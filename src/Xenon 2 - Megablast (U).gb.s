; md5 02d7df9a5ac5d859672b56be46343be1

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Xenon 2 - Megablast (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c008
.DEFINE cpl_joypad 1
.DEFINE current_rom_bank $ff00+$fb


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0ee9
.SECTION "joypad read" SIZE $29 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ld a,($c008)
    jp $0f12
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $08 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Xenon 2 Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
