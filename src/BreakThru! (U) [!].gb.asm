; md5 797580a91cf9dc710c37f5af04dbbca5

; ROMBANKS 8
; ROM "BreakThru! (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffc8
DEF joypad_2 EQU $ffc9
DEF current_rom_bank EQU $4000


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$00be] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$1974] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$56B9], BANK[$0001] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
