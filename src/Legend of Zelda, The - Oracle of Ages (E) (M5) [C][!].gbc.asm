; md5 825de040ea4dff66661693f8712b1bdb

.INCLUDE "includes/init.asm"
.ROMBANKS 128
.BACKGROUND "Legend of Zelda, The - Oracle of Ages (E) (M5) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $ffd8
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c481
.DEFINE joypad_2 $c480
.DEFINE joypad_3 $c482

.BANK $0000 SLOT 0
.ORG $3ef8
.SECTION "relocated read from joypad" SIZE $003b OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS
    
.ORG $0290
.SECTION "joypad read" SIZE 3 OVERWRITE
    call relocated_read_from_joypad
.ENDS
    

; save/load state
.BANK $0001 SLOT 1
.ORG $3000
.SECTION "save/load state" SIZE $0315 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
