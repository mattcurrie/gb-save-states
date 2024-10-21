; md5 8ed0e8d45a81ca34de625d930148a512

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Pokemon - Rote Edition (G) [S][!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $ffb8
.DEFINE game_uses_save_ram 1
.DEFINE current_sram_bank $fffd
.DEFINE uses_mbc5 1


; track current sram bank
.BANK $0000 SLOT 0
.ORG $0001
.SECTION "set sram bank" SIZE $0007 OVERWRITE
set_sram_bank:
    ld (current_sram_bank), a
    ld ($4000), a
    ret
.ENDS

.ORG $250d
.SECTION "call set sram bank 1" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $169d
.SECTION "call set sram bank 2" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $16eb
.SECTION "call set sram bank 3" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS

.BANK $0001 SLOT 1
.ORG $20cf
.SECTION "call set sram bank 4" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS

.BANK $001c SLOT 1
.ORG $3607
.SECTION "call set sram bank 5" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3674
.SECTION "call set sram bank 6" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $36a1
.SECTION "call set sram bank 7" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $376f
.SECTION "call set sram bank 8" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $37c5
.SECTION "call set sram bank 9" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $37f2
.SECTION "call set sram bank 10" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $38f3
.SECTION "call set sram bank 11" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a0e
.SECTION "call set sram bank 12" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a16
.SECTION "call set sram bank 13" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a6d
.SECTION "call set sram bank 14" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a75
.SECTION "call set sram bank 15" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3ab4
.SECTION "call set sram bank 16" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3b35
.SECTION "call set sram bank 17" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3b68
.SECTION "call set sram bank 18" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS

.BANK $000f SLOT 1
.ORG $2cef
.SECTION "call set sram bank 19" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS


; joypad
.DEFINE joypad $fff8

.BANK $0000 SLOT 0
.ORG $00bf
.SECTION "relocated read from joypad" SIZE $0040 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.ORG $0195
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0001 SLOT 1
.ORG $3c4a
.SECTION "save/load state" SIZE $0260 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
