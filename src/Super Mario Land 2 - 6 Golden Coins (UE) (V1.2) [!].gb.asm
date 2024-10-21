; md5 4bd6e929ec716a5c7fe7dc684860d551

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Super Mario Land 2 - 6 Golden Coins (UE) (V1.2) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$80
.DEFINE joypad_2 $ff00+$81
.DEFINE current_rom_bank $a24e
.DEFINE current_nr34_value $a43a
.DEFINE game_uses_save_ram 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $1fda
.SECTION "joypad read" SIZE $34 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"  
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $1d SLOT 1
.ORG $3800
.SECTION "save/load state" SIZE $600 OVERWRITE
    .DB "--- Super Mario Land 2 Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS