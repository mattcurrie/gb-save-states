; md5 4fd68c1cf8b57e90a5b11b054fc68b46

.INCLUDE "includes/init.asm"
.ROMBANKS 256
.BACKGROUND "Donald Duck - Goin' Quackers (U) (M5) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $0168
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c46e

.BANK $0000 SLOT 0
.ORG $0024
.SECTION "call relocated read from joypad in other bank" SIZE 26 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS

.BANK $0001 SLOT 1
.ORG $01db
.SECTION "joypad read" SIZE 3 OVERWRITE
    call invoke_relocated_read_from_joypad_in_other_bank
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $3a6d
.SECTION "save/load state" SIZE $02f0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
