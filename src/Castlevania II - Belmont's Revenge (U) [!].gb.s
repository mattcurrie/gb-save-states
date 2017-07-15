; md5 7c65e9da405d2225d079f75e56276822

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Castlevania II - Belmont's Revenge (U) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $c886
.DEFINE joypad_2 $c887
.DEFINE swap_joypad 1
.DEFINE current_rom_bank $7fff
.DEFINE current_nr34_value $c1c4
.DEFINE restore_sound 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $3503
.SECTION "joypad read" SIZE $33 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $8 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- Castlevania 2 Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
