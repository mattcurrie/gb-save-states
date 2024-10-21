; md5 131993b986f3ba1f682d8d74f050487b

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Hammerin' Harry - Ghost Building Company (U).gb"
.INCLUDE "includes/header.asm"


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
    .INCLUDE "includes/reset_ram.asm"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
