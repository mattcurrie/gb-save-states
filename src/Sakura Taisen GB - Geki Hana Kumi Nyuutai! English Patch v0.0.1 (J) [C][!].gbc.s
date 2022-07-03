; md5 ce604c67bf2806f5a6f736ba168ed271

.INCLUDE "includes/init.s"
.ROMBANKS 256
.BACKGROUND "Sakura Taisen GB - Geki Hana Kumi Nyuutai! English Patch v0.0.1 (J) [C][!].gbc"
.INCLUDE "includes/header.s"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $c292
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $c215

.BANK $0000 SLOT 0
.ORG $0064
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"
.ENDS

.ORG $03d1
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $3300
.SECTION "save/load state" SIZE $0295 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS


; fix for write to SRAM bank selection register at $08:$5f33
.BANK $0008 SLOT 1
.ORG $1f33
.SECTION "fix" SIZE $1 OVERWRITE
    dec hl
.ENDS

; Generated with patch-builder.py
