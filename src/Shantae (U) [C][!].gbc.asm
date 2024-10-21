; md5 028c4262dbb49f4fc462a6eb3e514d72

.INCLUDE "includes/init.asm"
.ROMBANKS 256
.BACKGROUND "Shantae (U) [C][!].gbc"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE is_cgb 1
.DEFINE current_rom_bank $ff91
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


;**********
;* vblank *
;**********

.DEFINE vblank_handler $0004
.DEFINE original_vblank_handler $0884
.INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

.BANK $0002 SLOT 1
.ORG $3841
.SECTION "save/load state" SIZE $0305 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
