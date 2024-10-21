; md5 e10f788da29e18934c3e9161b25b96c7

; ROMBANKS 16
; ROM "Gradius - The Interstellar Assault (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $c78e
DEF joypad_2 EQU $c78f
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $c7a4


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00ce] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0ca8] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7A20], BANK[$0002] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
