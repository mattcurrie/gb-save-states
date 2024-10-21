; md5 83bed4ebefeece45748258fd2ef105b3

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "SolarStriker (W) [!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $4004


; detect current rom bank based on unique values in rom
.DEFINE should_detect_rom_bank 1
.MACRO detect_rom_bank
    push bc
    push hl
    ld a, (current_rom_bank)
    ld b, a
    ld c, 1
    ld hl, @bank_values\@
-   ld a, (hl+)
    cp b
    jr z, @bank_detected\@
    inc c
    jr -
@bank_values\@:
.DB $06, $00, $01
@bank_detected\@:
    ld a, c
    pop hl
    pop bc
.ENDM


; joypad
.DEFINE joypad $cf80
.DEFINE joypad_2 $cf81

.BANK $0000 SLOT 0
.ORG $081a
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
.ENDS


; save/load state
.BANK $0004 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/joypad_read_and_check.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; Generated with patch-builder.py
