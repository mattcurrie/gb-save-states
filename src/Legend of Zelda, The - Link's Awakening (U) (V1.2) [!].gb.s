; md5 69d643bf4e37b3c133518517338b6a1c

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Legend of Zelda, The - Link's Awakening (U) (V1.2) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE current_rom_bank $dbaf
.DEFINE game_uses_save_ram 1


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00d3
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

.DEFINE joypad $ffcb
.DEFINE joypad_2 $ffcc
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $0092
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $2834
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $3d04
.SECTION "save/load state" SIZE $0245 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
