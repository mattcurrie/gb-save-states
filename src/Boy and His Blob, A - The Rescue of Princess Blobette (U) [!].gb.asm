; md5 81f7dee7546e630de075a3397349efb8

; ROMBANKS 4
; ROM "Boy and His Blob, A - The Rescue of Princess Blobette (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffe3
DEF joypad_2 EQU $ffe4
DEF current_rom_bank EQU $c2df


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0185

SECTION "reset ram", ROM0[$0061] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0000] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$03c6] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D80], BANK[$0001] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
