; md5 a66e4918edcd042ec171a57fe3ce36c3

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Kirby's Dream Land (UE) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $d04f
.DEFINE joypad_2 $ff00+$8b
.DEFINE current_rom_bank $d02c
.DEFINE current_nr34_value $de14


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $06e7
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*********************************
;* remap title screen key combos *
;*********************************

.BANK $06 SLOT 1
.ORG $0083
.SECTION "configuration mode" SIZE 1 OVERWRITE   
    .DB $82  ; use "down + b" instead of "select + down + b"
.ENDS
.ORG $0088
.SECTION "extra game" SIZE 1 OVERWRITE   
    .DB $41  ; use "up + a" instead of "select + up + a"
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0f SLOT 1
.ORG $3d00
.SECTION "save/load state" SIZE $2e0 OVERWRITE
    .DB "--- Kirby's Dream Land Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
