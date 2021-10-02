; md5 a5d383a5f6e9d61b505429257f2c44c1

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Crayon Shin-chan - Ora to Shiro wa Otomodachi Da yo (Japan).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8d
.DEFINE current_rom_bank $ff90


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3700
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE   
    .INCLUDE "includes/relocated_read_from_joypad.s"
    ret
.ENDS

;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $02e7
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $37a0
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
