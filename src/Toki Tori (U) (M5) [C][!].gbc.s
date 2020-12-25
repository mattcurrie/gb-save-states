; md5 e1bf59102bcd5e3601f4b24b3e873fd2

.INCLUDE "includes/init.s"
.ROMBANKS 64
.BACKGROUND "Toki Tori (U) (M5) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $4000
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c535
.DEFINE joypad_2 $c536

.BANK $0000 SLOT 0
.ORG $35ee
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ret
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $2eae
.SECTION "save/load state" SIZE $0315 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.s"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; Generated with patch-builder.py
