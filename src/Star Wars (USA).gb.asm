; md5 63098fde8f2dcb977c9a8f0389e0d033

; ROMBANKS 8
; ROM "Star Wars (USA).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff93
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $ff8c


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$1e66] ; length: $2a
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"

    ; Replicate register state of original read function
    ld a,[joypad]
    ld d, a

    ret
ENDSECTION

;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D40], BANK[$02] ; length: $2c0
    DB "--- XXXXX Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
