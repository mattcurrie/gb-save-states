; md5 b7598a51e0acc0d74ca8f464826371ed

.INCLUDE "includes/init.s"
.ROMBANKS 128
.BACKGROUND "Wario Land II (U) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $ffa4
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1
.DEFINE current_sram_bank $ffa3
.DEFINE current_nr34_value $cf63


; joypad
.DEFINE joypad $c60b
.DEFINE joypad_2 $c60c

.BANK $0000 SLOT 0
.ORG $0062
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $1a9d
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $33de
.SECTION "save/load state" SIZE $0300 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
