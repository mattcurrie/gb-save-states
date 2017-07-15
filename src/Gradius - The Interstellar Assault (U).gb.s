; md5 e10f788da29e18934c3e9161b25b96c7

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Gradius - The Interstellar Assault (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c78e
.DEFINE joypad_2 $c78f
.DEFINE current_rom_bank $c7a4
.DEFINE swap_joypad 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0ca8
.SECTION "joypad read" SIZE $34 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0f SLOT 1
.ORG $3da3
.SECTION "save/load state" SIZE $25c OVERWRITE
; not enough space...   .DB "--- Gradius Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
