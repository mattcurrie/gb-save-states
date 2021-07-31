; md5 f7e13de010decf104efa3db865971f34

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Shanghai Pocket (U) (V1.1) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $d414
.DEFINE uses_mbc5 1
.DEFINE preserve_registers 1
.DEFINE swap_joypad 1


; joypad
.DEFINE joypad $c0a4

.BANK $0000 SLOT 0
.ORG $00bf
.SECTION "relocated read from joypad" SIZE $003f OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $3ad2
.SECTION "joypad read" SIZE 8 OVERWRITE
    ld (joypad), a
    call relocated_read_from_joypad
    nop
    nop
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $2f81
.SECTION "save/load state" SIZE $0270 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
