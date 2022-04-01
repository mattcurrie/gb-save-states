; md5 8d885e185ad2a0cb5c9e3b152bd24583

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Contra - The Alien Wars (USA) (SGB Enhanced).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffec
.DEFINE joypad_2 $ffeb
.DEFINE read_joypad_value_from_b_register 1
.DEFINE current_rom_bank $ff8c


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $6a
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE   
    .INCLUDE "includes/relocated_read_from_joypad.s"
    ret
.ENDS

;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0744
.SECTION "joypad read" SIZE 3 OVERWRITE   
    call relocated_read_from_joypad
    ;nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $08 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $3fff
.SECTION "bank 8" SIZE 1 OVERWRITE
    .DB $8
.ENDS
