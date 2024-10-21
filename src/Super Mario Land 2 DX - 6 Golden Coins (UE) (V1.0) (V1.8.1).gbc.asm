; md5 946a4a60bbd5328ca2250d5f9f0606c7

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Super Mario Land 2 DX - 6 Golden Coins (UE) (V1.0) (V1.8.1).gbc"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE is_cgb 1
.DEFINE current_rom_bank $a24e
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1
.DEFINE restore_wave_ram 1


;**********
;* joypad *
;**********

.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $1fd7
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0001 SLOT 1
.ORG $2541
.SECTION "save/load state" SIZE $0305 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
