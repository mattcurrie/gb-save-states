; md5 7fe07271d04ed9e0bc0663dde55a2ae4

; ROMBANKS 16
; ROM "Megaman II (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8e


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a1] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0061] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0395] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3c94] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
