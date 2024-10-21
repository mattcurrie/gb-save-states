; md5 1d2c316f9f32727261328c7a49b22e2c

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Super Mario Land 2 - 6 Golden Coins (UE) (V1.1) [!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $a24e
.DEFINE game_uses_save_ram 1


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $005c
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $00bd
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $2007
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $000d SLOT 1
.ORG $1cdb
.SECTION "save/load state" SIZE $0245 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
