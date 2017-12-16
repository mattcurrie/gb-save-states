; md5 75963dd8e91147452bfa88f0d608d554

.INCLUDE "includes/init.s"
.ROMBANKS 8
.BACKGROUND "Gem Gem (J).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c
.DEFINE joypad_3 $d00e
.DEFINE current_rom_bank $c103
.DEFINE game_uses_save_ram 1


;*************
;* reset ram *
;*************

.DEFINE RESET_RAM_DONE $016c
.BANK $0000 SLOT 0

.ORG $00a3
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $0062
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $04dc
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0004 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $0245 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
