; md5 d300bf9412617a95b00b80fa468a8a04

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Alien Olympics 2044 AD (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff9a
.DEFINE current_rom_bank $c009


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $32e7
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $330f
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
