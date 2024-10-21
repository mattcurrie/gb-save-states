; md5 421a923ba483f65a967b8455500b8880

; ROMBANKS 8
; ROM "Robocop (U) (V1.0) [M][!].gb"


; config
DEF current_rom_bank EQU $c068


; reset ram
DEF RESET_RAM_DONE EQU $01a3

SECTION "reset ram", ROM0[$0062] ; length: $F
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
    ld a, $ff
    ld [$ff00+$00], a
    ld [$c08e], a

    ld a, b
    ld [$ff00+$b0], a
    call joypad_check
    ld a, [$ff00+$b0]
    ld b, a

    ret

    INCLUDE "includes/joypad_check.asm"
    ret
ENDSECTION

SECTION "joypad read", ROM0[$2974] ; length: 4
    jp relocated_read_from_joypad
ENDSECTION

SECTION "relocated read from joypad2", ROM0[$3f80] ; length: $0050
relocated_read_from_joypad2:
    ld b, a
    ld a,$30
    ld [$ff00+$00],a
    ld a, b

    ld [$ff00+$8a], a
    ld [$ff00+$b0], a
    call joypad_check
    ld a, [$ff00+$b0]
    ld [$ff00+$8a], a

    ret
ENDSECTION

SECTION "joypad read2", ROMX[$4D95], BANK[$0004] ; length: 4
    jp relocated_read_from_joypad2
ENDSECTION


; save/load state
SECTION "save/load state", ROM0[$3458] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
