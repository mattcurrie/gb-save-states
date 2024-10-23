; md5 9add23b6cf3a5b76305192da693dfd21

; ROMBANKS 8
; ROM "Hyper Dunk (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $c05f
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $c024


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00ed] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0393] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $03c4
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$66D6], BANK[$0001] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
