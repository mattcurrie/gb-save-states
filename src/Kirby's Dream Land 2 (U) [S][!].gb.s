; md5 ddb5bfae32b0ca39cf8ab6c46880126c

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Kirby's Dream Land 2 (U) [S][!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffc0        ; these bytes appear to be unused
.DEFINE joypad_2 $ffc1

.DEFINE current_rom_bank $ffa4
.DEFINE game_uses_save_ram 1
.DEFINE calling_from_vblank 1
.DEFINE uses_mbc5 1
.DEFINE current_nr34_value $ce14


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0044
.SECTION "vblank" SIZE $3 OVERWRITE
    jp invoke_relocated_read_from_joypad_in_other_bank
.ENDS

.ORG $0080
.SECTION "relocated read from joypad" SIZE $70 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $0159
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $20 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Kirby's Dream Land 2 Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
