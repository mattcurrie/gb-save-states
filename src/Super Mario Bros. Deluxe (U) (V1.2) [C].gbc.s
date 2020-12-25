; md5 b5a71128227f5bc953fd55cb0025807f

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Super Mario Bros. Deluxe (U) (V1.2) [C].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $ffbe
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c

.BANK $0000 SLOT 0
.ORG $0062
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $120d
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0003 SLOT 1
.ORG $39d1
.SECTION "save/load state" SIZE $0295 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
