; md5 b3e011cde1fa6b5bebcac15ac970c4a9

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Hook (E) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $c08d


; reset ram 
.DEFINE RESET_RAM_DONE $0150
.BANK $0000 SLOT 0

.ORG $0070
.SECTION "reset ram" SIZE $F OVERWRITE
    .INCLUDE "includes/reset_ram.s"
.ENDS

.ORG $0101
.SECTION "reset ram jump" SIZE 3 OVERWRITE
    jp RESET_RAM
.ENDS


; joypad
.DEFINE joypad $ffb0
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $02d2
.SECTION "joypad read" SIZE 4 OVERWRITE
    call relocated_read_from_joypad
    nop
.ENDS

.ORG $0000
.SECTION "relocated read from joypad" SIZE $003d OVERWRITE
relocated_read_from_joypad:
    ld a,$30
    ld ($ff00+$00),a

    ld a, b
    ld ($ff00+$b0), a
    .INCLUDE "includes/joypad_check.s"
    ld a, ($ff00+$b0)
    ld b, a

    ret
.ENDS


; save/load state
.BANK $0008 SLOT 1
.ORG $0000
.SECTION "save/load state" SIZE $0220 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
