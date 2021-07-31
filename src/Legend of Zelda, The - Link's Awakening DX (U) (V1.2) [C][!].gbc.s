; md5 7351daa3c0a91d8f6fe2fbcca6182478

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Legend of Zelda, The - Link's Awakening DX (U) (V1.2) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $dbaf
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ffcb
.DEFINE joypad_2 $ffcc
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $0006  ; note: manually changed to skip rom debug tool bytes at $0003-$0005
.SECTION "relocated read from joypad" SIZE $003a OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $2879
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0002 SLOT 1
.ORG $3cf5
.SECTION "save/load state" SIZE $0295 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
