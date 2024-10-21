; md5 25dfaca5120462af05532aaf4756776a

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Flintstones, The - King Rock Treasure Island (U).gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ffa6
.DEFINE joypad_2 $ffa7
.DEFINE current_rom_bank $7fff


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0380
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $03b0
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

.ORG $3fff
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $8
.ENDS


; Generated with patch-builder.py
