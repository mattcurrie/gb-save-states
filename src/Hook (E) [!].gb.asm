; md5 b3e011cde1fa6b5bebcac15ac970c4a9

; ROMBANKS 16
; ROM "Hook (E) [!].gb"


; config
DEF current_rom_bank EQU $c08d


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

SECTION "joypad read", ROM0[$02d2] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION

SECTION "relocated read from joypad", ROM0[$0000] ; length: $003d
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


; save/load state
SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
