; md5 e731fa23d9cd0c3d4dec7d5565beef61

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Simpsons, The - Escape from Camp Deadly (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8c
.DEFINE current_rom_bank $c698
.DEFINE restore_sound 1


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $00A0
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0cfa
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3940
.SECTION "save/load state" SIZE $480 OVERWRITE
    .DB "--- The Simpsons - Escape From Camp Deadly Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
