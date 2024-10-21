; md5 02d7df9a5ac5d859672b56be46343be1

; ROMBANKS 16
; ROM "Xenon 2 - Megablast (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $c008
DEF cpl_joypad EQU 1
DEF current_rom_bank EQU $ff00+$fb


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0ee9] ; length: $29
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ld a,[$c008]
    jp $0f12
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$08] ; length: $4000
    DB "--- Xenon 2 Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
