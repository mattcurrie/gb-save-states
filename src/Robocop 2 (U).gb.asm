; md5 3eb476d0c6347ce9034246f826866a58

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Robocop 2 (U).gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $d269


; reset ram 
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0070
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.asm"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $ffb0
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $3f00
.SECTION "relocated read from joypad" SIZE $0050 OVERWRITE
relocated_read_from_joypad:
    ld a,$30
    ld ($ff00+$00),a

    ld a, b
    ld ($ff00+$b0), a
    .INCLUDE "includes/joypad_check.asm"
    ld a, ($ff00+$b0)
    ld b, a

    ret
.ENDS

.ORG $02bd
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $3b00
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
