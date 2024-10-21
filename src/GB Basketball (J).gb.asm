; md5 f97902058640f3700b5acff422969ba3

; ROMBANKS 8
; ROM "GB Basketball (J).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff9a


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $03f0

SECTION "reset ram", ROM0[$00eb] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$00aa] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0713] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3d4a] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
