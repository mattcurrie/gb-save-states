; md5 05d5cf3404868efc22ac06e22ab5ba89

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Pop 'N TwinBee (E) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $d806
.DEFINE joypad_2 $d807
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $7fff
.DEFINE restore_wave_ram 1


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $00b0
.SECTION "call relocated read from joypad" SIZE $30 OVERWRITE
    call_relocated_read_from_joypad_in_other_bank:
        .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
        ret
.ENDS


;***************
;* joypad read *
;***************

.BANK $01 SLOT 1
.ORG $3112
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call call_relocated_read_from_joypad_in_other_bank
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $08 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Pop'n TwinBee Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $3fff
.SECTION "bank 8" SIZE 1 OVERWRITE
    .DB $8
.ENDS