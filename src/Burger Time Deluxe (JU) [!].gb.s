; md5 9627134ca3ea6e885275d30460ce3563

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Burger Time Deluxe (JU) [!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $ffb3
.DEFINE joypad_2 $ffb2
.DEFINE current_rom_bank $ffc7


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $027b
.SECTION "joypad read" SIZE $30 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    jp $02b3
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $03 SLOT 1
.ORG $3ce0
.SECTION "save/load state" SIZE $320 OVERWRITE
    .DB "--- Burger Time Deluxe Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
