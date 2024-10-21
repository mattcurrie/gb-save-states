; md5 421a923ba483f65a967b8455500b8880

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Robocop (U) (V1.0) [M][!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $c068


; reset ram 
.DEFINE RESET_RAM_DONE $01a3
.BANK $0000 SLOT 0

.ORG $0062
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
    ld a, $ff
    ld ($ff00+$00), a
    ld ($c08e), a

    ld a, b
    ld ($ff00+$b0), a
    call joypad_check
    ld a, ($ff00+$b0)
    ld b, a

    ret

    .INCLUDE "includes/joypad_check.s"    
    ret
.ENDS

.ORG $2974
.SECTION "joypad read" SIZE 4 OVERWRITE
    jp relocated_read_from_joypad
.ENDS

.ORG $3f80
.SECTION "relocated read from joypad2" SIZE $0050 OVERWRITE
relocated_read_from_joypad2:
    ld b, a
    ld a,$30
    ld ($ff00+$00),a
    ld a, b

    ld ($ff00+$8a), a
    ld ($ff00+$b0), a
    call joypad_check
    ld a, ($ff00+$b0)
    ld ($ff00+$8a), a

    ret
.ENDS

.BANK $0004 SLOT 1
.ORG $0d95
.SECTION "joypad read2" SIZE 4 OVERWRITE
    jp relocated_read_from_joypad2
.ENDS


; save/load state
.BANK $0000 SLOT 0
.ORG $3458
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
