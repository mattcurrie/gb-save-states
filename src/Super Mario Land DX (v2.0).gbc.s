; md5 119bdf89bdf38e489facd79cf251ccd0

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Super Mario Land DX (v2.0).gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $0159
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $3fd0
.SECTION "call relocated read from joypad in other bank" SIZE 26 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS

.BANK $0003 SLOT 1
.ORG $081e
.SECTION "joypad read" SIZE 4 OVERWRITE
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
.ENDS


; save/load state
.BANK $0004 SLOT 1
.ORG $2bda
.SECTION "save/load state" SIZE $0315 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
