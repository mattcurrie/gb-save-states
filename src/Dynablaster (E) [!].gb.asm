; md5 2eb9a6891fc79cd878d8bc12d04a0790

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Dynablaster (E) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8a
.DEFINE joypad_2 $ff00+$8b
.DEFINE current_rom_bank $ff00+$c6
.DEFINE current_nr34_value $d82a


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .DEFINE preserve_registers 1
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $04d3
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $1000
.SECTION "save/load state" SIZE $500 OVERWRITE
    .DB "--- Dynablaster Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
