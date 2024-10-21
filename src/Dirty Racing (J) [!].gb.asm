; md5 b2023017774d88ffe82a7d1b0af52c12

; ROMBANKS 8
; ROM "Dirty Racing (J) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c0a8
DEF cpl_joypad EQU 1


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a5] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0064] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2ddf] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3643] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
