; md5 812db832566202610bb1e42e643e2b93

; ROMBANKS 16
; ROM "Asterix (UE) (M5) [!].gb"


; config
DEF current_rom_bank EQU $4000


; detect current rom bank based on unique values in rom
DEF should_detect_rom_bank EQU 1
MACRO detect_rom_bank
    push bc
    push hl
    ld a, [current_rom_bank]
    ld b, a
    ld c, 1
    ld hl, .bank_values\@
:   ld a, [hl+]
    cp b
    jr z, .bank_detected\@
    inc c
    jr :-
.bank_values\@:
DB $5f, $00, $4b, $90, $56, $c0, $6e
.bank_detected\@:
    ld a, c
    pop hl
    pop bc
ENDM


; joypad
DEF joypad EQU $ff8a
DEF joypad_2 EQU $ff8b

SECTION "joypad read", ROM0[$1b06] ; length: 58
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ld a, [$ff00+$8a]       ; joypad read should return value in A
    ret
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$4001], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"

relocated_read_from_joypad:
    DB $C5, $0E, $00, $3E, $20, $E2, $F2, $F2, $F2, $47, $3E, $10, $E2, $78, $E6, $0F
    DB $CB, $37, $47, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2
    DB $F2, $E6, $0F, $B0, $2F, $47, $3E, $30, $E2, $F0, $8A, $A8, $A0, $E0, $8B, $F0
    DB $8A, $E0, $D7, $78, $E0, $8A, $E0, $91, $C1

    push bc
    INCLUDE "includes/joypad_check.asm"
    pop bc
    ret

    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$4000], BANK[$0008] ; length: 1
    DB $8
ENDSECTION


; Generated with patch-builder.py
