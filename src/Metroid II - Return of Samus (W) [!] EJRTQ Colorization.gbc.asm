; md5 f005cbcb60f4d9f3e4f6190e809cff1d

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Metroid II - Return of Samus (W) [!] EJRTQ Colorization.gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $d04e
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $ff80
.DEFINE joypad_2 $ff81

.BANK $0000 SLOT 0
.ORG $007c
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $22b7
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $3b98
.SECTION "save/load state" SIZE $0295 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


; mbc1->mbc5 patch
.BANK $0000 SLOT 0
.ORG $00c0
.SECTION "mbc1 to mbc5 patch" SIZE 24 OVERWRITE
set_rom_bank_bit_5:
    ld a, (current_rom_bank)
    or $20
    ; ld (current_rom_bank), a
    ld ($2100), a
    ret

reset_rom_bank_bit_5:
    ld a, (current_rom_bank)
    ld ($2100), a
    ret
.ENDS

.ORG $3f83
.SECTION "set bit 5" SIZE 5 OVERWRITE
    call set_rom_bank_bit_5
    nop
    nop
.ENDS

.ORG $3f9a
.SECTION "reset bit 5" SIZE 4 OVERWRITE
    call reset_rom_bank_bit_5
    nop
.ENDS
    

; Generated with patch-builder.py
