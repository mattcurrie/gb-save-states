; md5 f9445b104ebb70d8fb91c8c64452c0a4

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Wizards & Warriors Chapter X - The Fortress of Fear (E) [!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $4000


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00bc
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; vblank
.DEFINE vblank_handler $0004
.DEFINE original_vblank_handler $126a
.INCLUDE "includes/vblank_handler.asm"


; save/load state
.BANK $0004 SLOT 1
.ORG $0001
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS

.ORG $0000
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $4
.ENDS


; Generated with patch-builder.py
