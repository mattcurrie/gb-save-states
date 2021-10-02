; md5 7d76d2a9eaada93dc846efe1b2a815cc

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Kenyuu Densetsu Yaiba (Japan).gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $fffa
.DEFINE joypad_2 $fffb
.DEFINE current_rom_bank $ffc7


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $3ea0
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE   
    .INCLUDE "includes/relocated_read_from_joypad.s"
    ret
.ENDS

;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $0af7
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
	nop
	nop
	nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $c00
.SECTION "save/load state" SIZE $300 OVERWRITE
    .DB "--- XXXXX Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
