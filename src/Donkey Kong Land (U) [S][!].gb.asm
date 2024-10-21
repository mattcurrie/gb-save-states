; md5 89bb0d67d5af35c2ebf09d9aef2e34ad

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Donkey Kong Land (U) [S][!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ca03
.DEFINE joypad_2 $ca01
.DEFINE current_rom_bank $4000
.DEFINE preserve_registers 1
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1
.DEFINE restore_wave_ram 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $1d86
.SECTION "joypad read" SIZE $32 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"

    ld a, ($ca03)
    ld c,a
    jp $1db9
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $20 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB $20   ; rom bank number

    .DB "--- Donkey Kong Land Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
