; md5 4859ec2b18c4fabf489eb570c1d7d326

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Donkey Kong (JU) (V1.1) [S][!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b
.DEFINE current_rom_bank $ff8c
.DEFINE game_uses_save_ram 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $1052
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $3960
.SECTION "save/load state" SIZE $6A0 OVERWRITE
    .DB "--- Donkey Kong Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
