; md5 9639948ad274fa15281f549e5f9c4d87

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Metroid II - Return of Samus (W) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$80
.DEFINE joypad_2 $ff00+$81
.DEFINE current_rom_bank $d04e
.DEFINE game_uses_save_ram 1
.DEFINE current_nr34_value $cf1e


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
.ORG $22b7
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS

;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3c00
.SECTION "save/load state" SIZE $400 OVERWRITE
    .DB "--- Metroid II Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
