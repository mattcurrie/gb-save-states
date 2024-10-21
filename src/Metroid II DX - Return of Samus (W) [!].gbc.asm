; md5 57032a17c7e6aa00eb8e064a87279898

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Metroid II DX - Return of Samus (W) [!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $d04e
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $009e
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $22b7
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $3b88
.SECTION "save/load state" SIZE $0295 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
