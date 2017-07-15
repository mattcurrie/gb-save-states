; md5 d335d4d79ed002c7a67863e82ceaa472

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "B.C. Kid (E) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8d
.DEFINE joypad_2 $ff8e
.DEFINE current_rom_bank $c148


;***************
;* joypad read *
;***************

.DEFINE resume_read_from_joypad $0597
.BANK $00 SLOT 0
.ORG $0562
.SECTION "joypad read" SIZE $34 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ei 
    jp resume_read_from_joypad   
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $10 SLOT 1
.ORG $0
.SECTION "save/load state" SIZE $4000 OVERWRITE
    .DB "--- B.C. Kid Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS