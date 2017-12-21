; md5 2815ff13131712bcd00c3852d461b414

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Robin Hood - Prince of Thieves (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $fffe


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0070
.BANK $0000 SLOT 0

.ORG $0029
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;**********
;* joypad *
;**********

.DEFINE joypad $d053
.DEFINE joypad_2 $d054

.BANK $0000 SLOT 0
.ORG $0e8d
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $0ec1
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0003 SLOT 1
.ORG $3339
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
