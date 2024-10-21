; md5 db156bc96b528996ce1bf771195171af

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Final Fantasy Legend III (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b
.DEFINE current_rom_bank $c0b1
.DEFINE game_uses_save_ram 1


;***************
;* joypad read *
;***************

.BANK $0000 SLOT 0
.ORG $36f6
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0010 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
