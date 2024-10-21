; md5 7ef69878c3b5bc5532c69a51a2dd42f3

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Harvest Moon GB (U) [S][!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff8c
.DEFINE joypad_2 $ff8b
.DEFINE joypad_3 $ff8a
.DEFINE current_rom_bank $4000
.DEFINE game_uses_save_ram 1


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $00E4
.SECTION "relocated read from joypad" SIZE $1B OVERWRITE
    invoke_read:
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $2149
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call invoke_read
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $6 SLOT 1
.ORG $3a80
.SECTION "save/load state" SIZE $580 OVERWRITE
    .DB "--- Harvest Moon Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
