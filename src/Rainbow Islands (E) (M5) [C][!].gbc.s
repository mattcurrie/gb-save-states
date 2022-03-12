; md5 3c3f9f06b791df796b55ac94f2188ff2

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Rainbow Islands (E) (M5) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $ff89
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c134
.DEFINE joypad_2 $c135

.BANK $0000 SLOT 0
.ORG $0062
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $0395
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $3d8a
.SECTION "save/load state" SIZE $0270 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
