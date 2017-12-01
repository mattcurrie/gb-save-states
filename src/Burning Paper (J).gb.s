; md5 cb0a5d103c01d1d82d324602a45dd21b

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Burning Paper (J).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffb6
.DEFINE joypad_2 $ffb8
.DEFINE current_rom_bank $ffe3
.DEFINE restore_wave_ram 1


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;***************
;* joypad read *
;***************

.BANK $01 SLOT 1
.ORG $1d88
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $7 SLOT 1
.ORG $3000
.SECTION "save/load state" SIZE $1000 OVERWRITE
    .DB "--- Burning Paper Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
