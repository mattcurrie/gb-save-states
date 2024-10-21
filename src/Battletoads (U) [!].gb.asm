; md5 6d24c94d3acd89b4b703f7bd2a504833

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Battletoads (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c903
.DEFINE joypad_2 $c901
.DEFINE current_rom_bank $4000
.DEFINE do_not_disable_interrupts 1

;***************
;* joypad read *
;***************

.BANK $00 SLOT 0

.ORG $32ff
resume_joypad_read:

.ORG $32cc
.SECTION "joypad read" SIZE $33 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ld a,(joypad)
    ld c,a
    jr resume_joypad_read
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $08 SLOT 1
.ORG 0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Battletoads Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS

.ORG $3fff
.SECTION "bank 8" SIZE 1 OVERWRITE
    .DB $8
.ENDS