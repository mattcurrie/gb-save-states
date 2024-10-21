; md5 0d24eeff28040ff2a8f63de5bc8cbea2

; ROMBANKS 32
; ROM "Earthworm Jim (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c101
DEF joypad_2 EQU $c102
DEF current_rom_bank EQU $7fff


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$00b6] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0010] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$7FFF], BANK[$0010] ; length: 1
    DB $10
ENDSECTION


; Generated with patch-builder.py
