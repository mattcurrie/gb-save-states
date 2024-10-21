; md5 50927e843568814f7ed45ec4f944bd8b

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Pokemon - Blue Version (UE) [S][!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $ffb8
.DEFINE game_uses_save_ram 1
.DEFINE current_sram_bank $fffd
.DEFINE uses_mbc5 1


; mbc 5 fix
.BANK $0001 SLOT 1
.ORG $2763
.SECTION "patch rom bank 0 req" SIZE $1 OVERWRITE
    .DB $01
.ENDS


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
.ORG $20a8
.SECTION "call set sram bank 4" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS

.BANK $001c SLOT 1
.ORG $362d
.SECTION "call set sram bank 5" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $369a
.SECTION "call set sram bank 6" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $36c7
.SECTION "call set sram bank 7" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3adb
.SECTION "call set sram bank 8" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3796
.SECTION "call set sram bank 9" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $37ec
.SECTION "call set sram bank 10" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3819
.SECTION "call set sram bank 11" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $391a
.SECTION "call set sram bank 12" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a35
.SECTION "call set sram bank 13" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a3d
.SECTION "call set sram bank 14" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a94
.SECTION "call set sram bank 15" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3a9c
.SECTION "call set sram bank 16" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3b5c
.SECTION "call set sram bank 17" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS
.ORG $3b8f
.SECTION "call set sram bank 18" SIZE $3 OVERWRITE
    call set_sram_bank
.ENDS

.BANK $000f SLOT 1
.ORG $2ce1
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
