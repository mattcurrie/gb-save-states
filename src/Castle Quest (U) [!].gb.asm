; md5 03ce24437224ff296a71f402663a0ee9

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Castle Quest (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ffd9
.DEFINE current_rom_bank $c000


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0029
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
.ORG $01d2
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $01fa
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $3b04
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
