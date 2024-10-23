; md5 acac255e33082dde52eee7af941d8681

; ROMBANKS 8
; ROM "R-Type II (Japan).gb"


;**********
;* config *
;**********

DEF joypad EQU $d006
DEF joypad_2 EQU $d007
DEF current_rom_bank EQU $d093


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$3d20] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
    ret
ENDSECTION

;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$637] ; length: 3
    call relocated_read_from_joypad
    ;nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3d80] ; length: $0220
    DB "--- XXXXX Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
