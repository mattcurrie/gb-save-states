; md5 57726c28dc09949029a154f63b891dd0

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Addams Family, The - Pugsley's Scavenger Hunt (U).gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff9a
.DEFINE current_rom_bank $c144


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0158
.BANK $0000 SLOT 0

.ORG $00cf
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
.ORG $08c1
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $08e9
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
