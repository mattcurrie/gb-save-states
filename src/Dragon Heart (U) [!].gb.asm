; md5 f9e94b9a134d900a3b971e206f4e826c

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Dragon Heart (U) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* vblank *
;**********

.DEFINE vblank_handler $00dc
.DEFINE original_vblank_handler $20ef
.INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

.BANK $0000 SLOT 0
.ORG $3cd7
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
