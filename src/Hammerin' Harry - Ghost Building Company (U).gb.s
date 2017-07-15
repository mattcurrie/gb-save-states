; md5 131993b986f3ba1f682d8d74f050487b

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Hammerin' Harry - Ghost Building Company (U).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$fb

.DEFINE current_nr34_value $4821


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $0150
.BANK $00 SLOT 0
.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $1cec
.SECTION "joypad read call" SIZE 8 OVERWRITE
    push bc
    call relocated_read_from_joypad
    pop bc
    ld a,($ff00+$fb)
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $00 SLOT 0
.ORG $3600
.SECTION "save/load state" SIZE $A00 OVERWRITE
    .DB "--- Hammerin' Harry Save Patch ---"
    .INCLUDE "includes/reset_ram.s"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
