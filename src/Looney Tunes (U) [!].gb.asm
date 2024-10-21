; md5 6e9dd3c1fb169da79292a1962e95a884

; ROMBANKS 8
; ROM "Looney Tunes (U) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $c4f7


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a3] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* joypad *
;**********

DEF joypad EQU $ffe1
DEF joypad_2 EQU $ffe2

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0cb0] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C1B], BANK[$0004] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
