; md5 16bb3fb83e8cbbf2c4c510b9f50cf4ee

.INCLUDE "includes/init.asm"
.ROMBANKS 128
.BACKGROUND "Wario Land 3 (JU) (M2) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $c5ff
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1
.DEFINE current_sram_bank $c08e


; joypad
.DEFINE joypad $c093
.DEFINE joypad_2 $c094

.BANK $0000 SLOT 0
.ORG $009b
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $0413
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $1c6d
.SECTION "save/load state" SIZE $02bd OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
