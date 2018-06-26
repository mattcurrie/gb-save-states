; md5 0221de99d11f50f79430c8ff9b430994

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Teenage Mutant Ninja Turtles - Back From the Sewers (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $c7a7


;**********
;* joypad *
;**********

.DEFINE joypad $c78e
.DEFINE joypad_2 $c78f
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $00be
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $083b
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0010 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
