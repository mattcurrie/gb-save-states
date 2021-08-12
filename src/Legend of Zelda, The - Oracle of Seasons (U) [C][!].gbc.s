; md5 f2dc6c4e093e4f8c6cbea80e8dbd62cb

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Legend of Zelda, The - Oracle of Seasons (U) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $ff97
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c481
.DEFINE joypad_2 $c480
.DEFINE joypad_3 $c482

.BANK $0000 SLOT 0
.ORG $3ef8
.SECTION "relocated read from joypad" SIZE $003b OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $0290
.SECTION "joypad read" SIZE 3 OVERWRITE
    call relocated_read_from_joypad
.ENDS


; save/load state
.BANK $0006 SLOT 1
.ORG $3a32
.SECTION "save/load state" SIZE $0315 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
