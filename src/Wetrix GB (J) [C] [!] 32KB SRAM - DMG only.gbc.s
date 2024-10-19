; md5 f36cd3e0a8a8eacf4a9c5a2a755f237e

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Wetrix GB (J) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $ffb1
.DEFINE uses_mbc5 1


; reset ram
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0001
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $ff8c
.DEFINE joypad_2 $ff8d

.BANK $0000 SLOT 0
.ORG $007e
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $08c6
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $119e
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
