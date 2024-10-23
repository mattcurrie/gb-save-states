; md5 64f43161eb16eb1be99262c36867bc79

; ROMBANKS 16
; ROM "Prehistorik Man (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$8d
DEF current_rom_bank EQU $ffce
DEF restore_sound EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$119b] ; length: $1c
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ld a,[$ff00+$8d]
    nop
ENDSECTION

SECTION "joypad read nops", ROM0[$11be] ; length: 3
    nop
    nop
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$8] ; length: $4000
    DB "--- Prehistorik Man Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
