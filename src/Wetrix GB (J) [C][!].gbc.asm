; md5 f36cd3e0a8a8eacf4a9c5a2a755f237e

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Wetrix GB (J) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $ffb1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ff8c
.DEFINE joypad_2 $ff8d

.BANK $0000 SLOT 0
.ORG $007e
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $08c6
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $119e
.SECTION "save/load state" SIZE $0270 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
