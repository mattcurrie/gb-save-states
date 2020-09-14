; md5 79d6e6515905ec3fbcbd9e50ff469000

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Bonk's Adventure (U) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $c148


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0024
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $ff8d
.DEFINE joypad_2 $ff8e

.BANK $0000 SLOT 0
.ORG $0071
.SECTION "relocated read from joypad" SIZE $0035 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $0592
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $3b91
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
