; md5 0611b365116b22c1aaa7e3ce4faed5ed

; ROMBANKS 8
; ROM "Home Alone 2 (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8c


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0444

SECTION "reset ram", ROM0[$00ad] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$006c] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$05f9] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3cdd] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
