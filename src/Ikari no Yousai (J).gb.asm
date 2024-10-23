; md5 ac04d143de6734e181a223d05178bde8

; ROMBANKS 8
; ROM "Ikari no Yousai (J).gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ffcc


;**********
;* joypad *
;**********

DEF joypad EQU $ffd7
DEF joypad_2 EQU $ffd8

SECTION "joypad read", ROM0[$015b] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $019b
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C2A], BANK[$0002] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
