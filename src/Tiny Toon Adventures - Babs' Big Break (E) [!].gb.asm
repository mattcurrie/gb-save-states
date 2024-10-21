; md5 cbb45188c780ce5bbdf502ceb2b9994a

.INCLUDE "includes/init.asm"
.ROMBANKS 8
.BACKGROUND "Tiny Toon Adventures - Babs' Big Break (E) [!].gb"
.INCLUDE "includes/header.asm"


; config
.DEFINE current_rom_bank $015a
.DEFINE calling_from_vblank 1
.DEFINE already_changed_rom_bank 1
.DEFINE interrupts_already_disabled 1


; joypad
.DEFINE joypad $c986
.DEFINE joypad_2 $c987
.DEFINE swap_joypad 1

.BANK $0000 SLOT 0
.ORG $00f1
.SECTION "call relocated read from joypad in other bank part" SIZE 14 OVERWRITE
invoke_relocated_read_from_joypad_in_other_bank:
    ld a,:relocated_read_from_joypad
    ld ($2000),a
    call relocated_read_from_joypad
    ld a, 1         ; joypad read function is in bank 1
    ld ($2000),a
    ret
.ENDS

.BANK $0001 SLOT 1
.ORG $0209
.SECTION "joypad read" SIZE 4 OVERWRITE
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
.ENDS


; save/load state
.BANK $0003 SLOT 1
.ORG $3d19
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS
