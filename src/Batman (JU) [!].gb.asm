; md5 03c6d84a951be6703b7458478f4277b9

; ROMBANKS 8
; ROM "Batman (JU) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$b4
DEF joypad_2 EQU $ff00+$b5


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0d28] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3d00] ; length: $300
    DB "--- Batman Save Patch v1.0 ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
