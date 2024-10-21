; md5 cd9027e147f4605f26ee261c537441b3

.INCLUDE "includes/init.asm"
.ROMBANKS 4
.BACKGROUND "Pac-Man (U) (Namco).gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $d600


; reset ram
.DEFINE RESET_RAM_DONE $0867
.BANK $0000 SLOT 0

.ORG $00d4
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; vblank
.DEFINE vblank_handler $0004
.DEFINE original_vblank_handler $03bb
.INCLUDE "includes/vblank_handler.asm"


; save/load state
.BANK $0000 SLOT 0
.ORG $3381
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
