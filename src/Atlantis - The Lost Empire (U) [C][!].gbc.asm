; md5 5aab47cf957c82c969bbc0a93232f883

.INCLUDE "includes/init.asm"
.ROMBANKS 128
.BACKGROUND "Atlantis - The Lost Empire (U) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $7fff
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c106
.DEFINE joypad_2 $c107

.BANK $0000 SLOT 0
.ORG $00b8
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $378b
.SECTION "save/load state" SIZE $02f0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
