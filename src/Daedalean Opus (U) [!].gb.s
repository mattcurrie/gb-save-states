; md5 34b3d0f0843b83e5b0e00bc3d0669793

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Daedalean Opus (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $d000
.DEFINE joypad_2 $d001
.DEFINE current_rom_bank $0179


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00ea
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $00aa
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $07a7
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
