; md5 131993b986f3ba1f682d8d74f050487b

; ROMBANKS 16
; ROM "Hammerin' Harry - Ghost Building Company (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$fb

DEF current_nr34_value EQU $4821


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150
SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read call", ROM0[$1cec] ; length: 8
    push bc
    call relocated_read_from_joypad
    pop bc
    ld a,[$ff00+$fb]
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3600] ; length: $A00
    DB "--- Hammerin' Harry Save Patch ---"
    INCLUDE "includes/reset_ram.asm"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
