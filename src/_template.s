; md5 XXXXXXXXXXXXXXXXXXXXXX

.INCLUDE "includes/init.s"
.ROMBANKS zzzzzzzzzz
.BACKGROUND "aaaaaaaaaaaaaaaaaaa"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $tttt
.DEFINE joypad_2 $ssss
.DEFINE current_rom_bank $iiii


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/reset_ram.s"
.ENDS


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $qqqq
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $zz SLOT 1
.ORG $xxxx
.SECTION "save/load state" SIZE $yyyy OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
