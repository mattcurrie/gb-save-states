; md5 64f43161eb16eb1be99262c36867bc79

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Prehistorik Man (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$8d
.DEFINE current_rom_bank $ffce
.DEFINE restore_sound 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $119b
.SECTION "joypad read" SIZE $1c OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ld a,($ff00+$8d)
    nop
.ENDS

.ORG $11be
.SECTION "joypad read nops" SIZE 3 OVERWRITE   
    nop
    nop
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $8 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Prehistorik Man Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"   
    .INCLUDE "includes/save_state_includes.s"
.ENDS
