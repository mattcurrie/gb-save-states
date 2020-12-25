; md5 f94f61e6beaec6222e0d35229e2e271e

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Balloon Fight GB (J) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $ffca
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ffa0

.BANK $0000 SLOT 0
.ORG $0062
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $0b72
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $3cd3
.SECTION "save/load state" SIZE $0300 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
