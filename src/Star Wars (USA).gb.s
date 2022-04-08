; md5 63098fde8f2dcb977c9a8f0389e0d033

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Star Wars (USA).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff93
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $ff8c


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $1e66
.SECTION "joypad read" SIZE $2a OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"

    ; Replicate register state of original read function
    ld a,(joypad)
    ld d, a

    ret
.ENDS

;*******************
;* save/load state *
;*******************

.BANK $02 SLOT 1
.ORG $3d40
.SECTION "save/load state" SIZE $2c0 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
