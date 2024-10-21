; md5 c94afb46cada0118aa8ff08cc07749a4

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Parodius (UE) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $cb86
.DEFINE joypad_2 $cb87
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $7fff
.DEFINE current_nr34_value $c1b6


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $00a0
.SECTION "will read from joypad" SIZE $60 OVERWRITE
    will_read_from_joypad:
        call $4087
        .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
        ret
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $02fd
.SECTION "joypad read" SIZE 3 OVERWRITE   
    call will_read_from_joypad
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0e SLOT 1
.ORG $3d10
.SECTION "save/load state" SIZE $25f OVERWRITE
; no space    .DB "--- Parodius Save Patch ---"
    .DEFINE joypad_read_already_finished 1
    .INCLUDE "includes/relocated_read_from_joypad.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
