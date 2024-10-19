; md5 812db832566202610bb1e42e643e2b93

.INCLUDE "includes/init.s"
.ROMBANKS 16
.BACKGROUND "Asterix (UE) (M5) [!].gb"
.INCLUDE "includes/header.s"


; config
.DEFINE current_rom_bank $4000


; detect current rom bank based on unique values in rom
.DEFINE should_detect_rom_bank 1
.MACRO detect_rom_bank
    push bc
    push hl
    ld a, (current_rom_bank)
    ld b, a
    ld c, 1
    ld hl, @bank_values\@
-   ld a, (hl+)
    cp b
    jr z, @bank_detected\@
    inc c
    jr -
@bank_values\@:
.DB $5f, $00, $4b, $90, $56, $c0, $6e
@bank_detected\@:
    ld a, c
    pop hl
    pop bc
.ENDM


; joypad
.DEFINE joypad $ff8a
.DEFINE joypad_2 $ff8b

.BANK $0000 SLOT 0
.ORG $1b06
.SECTION "joypad read" SIZE 58 OVERWRITE
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"
    ld a, ($ff00+$8a)       ; joypad read should return value in A
    ret
.ENDS


; save/load state
.BANK $0008 SLOT 1
.ORG $0001
.SECTION "save/load state" SIZE $02a0 OVERWRITE
    .DB "--- Save Patch ---"

relocated_read_from_joypad:
    .DB $C5, $0E, $00, $3E, $20, $E2, $F2, $F2, $F2, $47, $3E, $10, $E2, $78, $E6, $0F
    .DB $CB, $37, $47, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2, $F2
    .DB $F2, $E6, $0F, $B0, $2F, $47, $3E, $30, $E2, $F0, $8A, $A8, $A0, $E0, $8B, $F0
    .DB $8A, $E0, $D7, $78, $E0, $8A, $E0, $91, $C1

    push bc
    .INCLUDE "includes/joypad_check.s"
    pop bc
    ret

    .INCLUDE "includes/save_state_includes.s"
.ENDS

.ORG $0000
.SECTION "new bank" SIZE 1 OVERWRITE
    .DB $8
.ENDS


; Generated with patch-builder.py
