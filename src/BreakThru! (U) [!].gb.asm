; md5 797580a91cf9dc710c37f5af04dbbca5

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "BreakThru! (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ffc8
.DEFINE joypad_2 $ffc9
.DEFINE current_rom_bank $4000


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $00be
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $1974
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0001 SLOT 1
.ORG $16b9
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
