; md5 5cfa323ad8d8e4a6d50022d5c64b46fd

.INCLUDE "includes/init.asm"
.ROMBANKS 4
.BACKGROUND "Ms. Pac-Man (E).gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $4000


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00a3
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $ff8b
.DEFINE joypad_2 $ff8c

.BANK $0000 SLOT 0
.ORG $0062
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $03ea
.SECTION "joypad read" SIZE 5 OVERWRITE
    call relocated_read_from_joypad
    nop
    nop
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $3070
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
