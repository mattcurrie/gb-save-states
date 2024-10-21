; md5 4c614f884a07872f12056ad1a421e1f9

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Megaman III (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8a
.DEFINE joypad_2 $ff00+$8b
.DEFINE current_rom_bank $de93


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3fa0
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $14df
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3d1d
.SECTION "save/load state" SIZE $2e3 OVERWRITE
    .DB "--- Megaman 3 Save Patch v1.0 ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
