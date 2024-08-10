; md5 43189b859c0036119f233d46b1f2e9fd

.INCLUDE "includes/init.s"
.ROMBANKS 4
.BACKGROUND "Bugs Bunny (U) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $ffcb


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $00c4
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; vblank
.DEFINE vblank_handler $000c
.DEFINE original_vblank_handler $01a2
.INCLUDE "includes/vblank_handler.s"


; save/load state
.BANK $0001 SLOT 1
.ORG $3aed
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
