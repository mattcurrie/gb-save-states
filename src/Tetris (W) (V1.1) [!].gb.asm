; md5 982ed5d2b12a0377eb14bcdc4123744e

.INCLUDE "includes/init.asm"
.ROMBANKS 4
.BACKGROUND "Tetris (W) (V1.1) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81
.DEFINE current_rom_bank $0087   ; value at this address is $01
.DEFINE current_nr34_value $dfba


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $29a6
.SECTION "joypad read" SIZE $3c OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $02 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Tetris Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
