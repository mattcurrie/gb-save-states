; md5 7f970d79f06cfb4270dea4b051277098

.INCLUDE "includes/init.s"
.ROMBANKS 4                      ; no free space so need to double the number of rom banks
.BACKGROUND "Bubble Ghost (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c
.DEFINE current_rom_bank $02f0   ; address contains the value $01
.DEFINE restore_wave_ram 1

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
.ORG $04df
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $2 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Bubble Ghost Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
