; md5 ff3e6d70d42987dd7f6214067dc83afe

; ROMBANKS 8
; ROM "Double Dribble - 5 on 5 (U) [!].gb"


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

SECTION "reset ram", ROM0[$00ec] ; length: $F
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

SECTION "save/load state", ROMX[$66D5], BANK[$0001] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
