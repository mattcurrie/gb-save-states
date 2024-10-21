; md5 cbb45188c780ce5bbdf502ceb2b9994a

; ROMBANKS 8
; ROM "Tiny Toon Adventures - Babs' Big Break (E) [!].gb"


; config
DEF current_rom_bank EQU $015a
DEF calling_from_vblank EQU 1
DEF already_changed_rom_bank EQU 1
DEF interrupts_already_disabled EQU 1


; joypad
DEF joypad EQU $c986
DEF joypad_2 EQU $c987
DEF swap_joypad EQU 1

SECTION "call relocated read from joypad in other bank part", ROM0[$00f1] ; length: 14
invoke_relocated_read_from_joypad_in_other_bank:
    ld a,BANK(relocated_read_from_joypad)
    ld [$2000],a
    call relocated_read_from_joypad
    ld a, 1         ; joypad read function is in bank 1
    ld [$2000],a
    ret
ENDSECTION

SECTION "joypad read", ROMX[$4209], BANK[$0001] ; length: 4
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7D19], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
