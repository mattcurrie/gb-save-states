; md5 0b4410c6b94d6359dba5609ae9a32909

.INCLUDE "includes/init.asm"
.ROMBANKS 4
.BACKGROUND "Castlevania Adventure, The (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $c00c
.DEFINE joypad_2 $c00d
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $7fff
.DEFINE current_nr34_value $c236


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0232
.SECTION "joypad read" SIZE $33 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $03 SLOT 1
.ORG $3d4e

.SECTION "save/load state" SIZE $2B0 OVERWRITE
    .DB "--- Castlevania Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
