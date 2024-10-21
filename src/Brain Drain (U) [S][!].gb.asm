; md5 0c7beead4f65e97a23b718ce20a1bf55

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Brain Drain (U) [S][!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

; MANUAL EDIT - joypad detected incorrectly
.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b

.DEFINE current_rom_bank $ff9f


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00a1
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0061
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

; MANUAL EDIT - wrong value for .ORG directive
.ORG $039d
.SECTION "joypad read" SIZE 3 OVERWRITE
    call relocated_read_from_joypad
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0007 SLOT 1
.ORG $1a58
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
