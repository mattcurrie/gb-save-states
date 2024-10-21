; md5 4681f5b931a2e60ca163facd1adf56ed

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Megaman Xtreme (U) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $7ffe
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ff8f
.DEFINE joypad_2 $ff90
.DEFINE preserve_registers 1

.BANK $0000 SLOT 0
.ORG $0087
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $0911
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0002 SLOT 1
.ORG $3d3f
.SECTION "save/load state" SIZE $0295 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
