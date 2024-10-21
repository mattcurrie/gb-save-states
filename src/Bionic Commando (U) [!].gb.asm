; md5 f89a33de3fa660a13ec29bb323efffa9

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Bionic Commando (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c0c0
.DEFINE joypad_2 $c0c1
.DEFINE current_rom_bank $c0d3
.DEFINE current_nr34_value $c47a
.DEFINE restore_sound 1


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3f00
.SECTION "relocated read from joypad" SIZE $ff OVERWRITE
    .DEFINE interrupts_already_disabled 1
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0aef
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS

;*******************
;* save/load state *
;*******************

.BANK $0f SLOT 1
.ORG $3d00

.SECTION "save/load state" SIZE $300 OVERWRITE
    .DB "--- Bionic Commando Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
