; md5 ee6bcaa3ff5b992bac378591a02b2e6f

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Wario Land - Super Mario Land 3 (W) Color Edition (v1.2).gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $a8c5
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $11f0
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


; save/load state
.BANK $0011 SLOT 1
.ORG $1c01
.SECTION "save/load state" SIZE $0315 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
