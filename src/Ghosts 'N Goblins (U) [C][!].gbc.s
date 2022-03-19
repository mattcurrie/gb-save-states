; md5 9b846e9a4eb6b80cdbc8e6c82f2b9e9e

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Ghosts 'N Goblins (U) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $7fff
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c0e0
.DEFINE joypad_2 $c0e1

.BANK $0000 SLOT 0
.ORG $00bf
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $009b
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0002 SLOT 1
.ORG $1bd9
.SECTION "save/load state" SIZE $0270 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
