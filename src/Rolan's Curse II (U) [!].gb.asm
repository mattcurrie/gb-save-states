; md5 27f2c99b13cbdb5a5be4afce87b9039b

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Rolan's Curse II (U) [!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $ff8e
.DEFINE game_uses_save_ram 1


;*************
;* reset ram *
;*************
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00c0
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


;**********
;* vblank *
;**********

.DEFINE vblank_handler $0062
.DEFINE original_vblank_handler $039c
.DEFINE original_vblank_handler_pushes $f5 $c5 $d5 $e5
.INCLUDE "includes/vblank_handler.asm"


; save/load state
.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
