; md5 6e30394fd7ef4a4dc3fe1edd9fc69f72

; ROMBANKS 64
; ROM "Donkey Kong Land 2 (UE) [S][!].gb"


; config
DEF current_rom_bank EQU $4000
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $dea1
DEF joypad_2 EQU $dea2

SECTION "joypad read", ROM0[$383a] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $386d
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4001], BANK[$0020] ; length: $02c5
    DB "--- Save Patch ---"
relocated_read_from_joypad:
    INCLUDE "includes/joypad_read.asm"

    ld a, [$dea1]
    cpl
    and c
    ld [$dea2], a
    ld a, c
    ld [$dea1], a
    ld a, $30
    ld [$ff00+$00], a

    push bc
    INCLUDE "includes/joypad_check.asm"
    pop bc
    ret

    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$4000], BANK[$0020] ; length: 1
    DB $20
ENDSECTION
