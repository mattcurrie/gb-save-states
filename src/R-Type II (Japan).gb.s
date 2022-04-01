; md5 acac255e33082dde52eee7af941d8681

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "R-Type II (Japan).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $d006
.DEFINE joypad_2 $d007
.DEFINE current_rom_bank $d093


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3d20
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE   
    .INCLUDE "includes/relocated_read_from_joypad.s"
    ret
.ENDS

;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $637
.SECTION "joypad read" SIZE 3 OVERWRITE   
    call relocated_read_from_joypad
    ;nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $3d80
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS