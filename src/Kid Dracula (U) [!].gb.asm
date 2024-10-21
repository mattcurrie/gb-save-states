; md5 24a6b4457a511cc667e9ac25417401ab

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Kid Dracula (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c9c6
.DEFINE joypad_2 $c9c7
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $7fff
.DEFINE current_nr34_value $c7ed


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3f00
.SECTION "relocated read from joypad" SIZE $d0 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0537
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $03 SLOT 1
.ORG $3d00
.SECTION "save/load state" SIZE $2fe OVERWRITE
    .DB "--- Kid Dracula Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
