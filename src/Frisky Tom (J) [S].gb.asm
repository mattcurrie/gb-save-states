; md5 f49fef0c5cc023462d7f84286dc19976

; ROMBANKS 8
; ROM "Frisky Tom (J) [S].gb"


;**********
;* config *
;**********

DEF joypad EQU $c007
DEF swap_joypad EQU 1
DEF cpl_joypad EQU 1


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


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$12a3] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$33cb] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
