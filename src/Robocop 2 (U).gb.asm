; md5 3eb476d0c6347ce9034246f826866a58

; ROMBANKS 8
; ROM "Robocop 2 (U).gb"


; config
DEF current_rom_bank EQU $d269


; reset ram
DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0070] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


; joypad
DEF joypad EQU $ffb0
DEF swap_joypad EQU 1

SECTION "relocated read from joypad", ROM0[$3f00] ; length: $0050
relocated_read_from_joypad:
    ld a,$30
    ld [$ff00+$00],a

    ld a, b
    ld [$ff00+$b0], a
    INCLUDE "includes/joypad_check.asm"
    ld a, [$ff00+$b0]
    ld b, a

    ret
ENDSECTION

SECTION "joypad read", ROM0[$02bd] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$3b00] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
