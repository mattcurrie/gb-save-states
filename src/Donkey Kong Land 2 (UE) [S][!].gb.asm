; md5 6e30394fd7ef4a4dc3fe1edd9fc69f72

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Donkey Kong Land 2 (UE) [S][!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $4000
.DEFINE game_uses_save_ram 1
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $dea1
.DEFINE joypad_2 $dea2

.BANK $0000 SLOT 0
.ORG $383a
.SECTION "joypad read" SIZE $20 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $386d
.ENDS


; save/load state
.BANK $0020 SLOT 1
.ORG $0001
.SECTION "save/load state" SIZE $02c5 OVERWRITE
    .DB "--- Save Patch ---"
relocated_read_from_joypad:
    .INCLUDE "includes/joypad_read.asm"

    ld a, ($dea1)
    cpl
    and c
    ld ($dea2), a
    ld a, c
    ld ($dea1), a
    ld a, $30
    ld ($ff00+$00), a

    push bc
    .INCLUDE "includes/joypad_check.asm"
    pop bc
    ret

    .INCLUDE "includes/save_state_includes.asm"
.ENDS

.ORG $0000
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $20
.ENDS

