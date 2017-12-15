; md5 81f7dee7546e630de075a3397349efb8

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Boy and His Blob, A - The Rescue of Princess Blobette (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffe3
.DEFINE joypad_2 $ffe4
.DEFINE current_rom_bank $c2df


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0185
.BANK $0000 SLOT 0

.ORG $0061
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
.ORG $0000
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $03c6
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0001 SLOT 1
.ORG $3d80
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
