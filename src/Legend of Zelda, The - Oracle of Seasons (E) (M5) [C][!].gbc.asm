; md5 4ca44cbdd4e05c9b3c22da96d3de6338

.INCLUDE "includes/init.asm"
.ROMBANKS 128
.BACKGROUND "Legend of Zelda, The - Oracle of Seasons (E) (M5) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $7fff
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; vblank
.DEFINE vblank_handler $3ef3
.DEFINE original_vblank_handler $09f6
.DEFINE original_vblank_handler_pushes $f5 $c5 $d5 $e5
.INCLUDE "includes/vblank_handler.asm"


; save/load state
.BANK $0033 SLOT 1
.ORG $0001
.SECTION "save/load state" SIZE $0315 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
