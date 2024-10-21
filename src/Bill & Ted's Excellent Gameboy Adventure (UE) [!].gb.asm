; md5 9d94d01d3133165d4469bb27d58f0f6c

; ROMBANKS 8
; ROM "Bill & Ted's Excellent Gameboy Adventure (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8e
DEF joypad_2 EQU $ff8f


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0070

SECTION "reset ram", ROM0[$0028] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$02aa] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $02db
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3ce1] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
