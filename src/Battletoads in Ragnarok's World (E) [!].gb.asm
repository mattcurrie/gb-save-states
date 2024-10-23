; md5 bc76c0516129c6791e4087f93f5d3c99

; ROMBANKS 16
; ROM "Battletoads in Ragnarok's World (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ca03
DEF joypad_2 EQU $ca01
DEF current_rom_bank EQU $4000


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$2e5e] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $2e91
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4001], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$4000], BANK[$0008] ; length: 1
    DB $8
ENDSECTION


; Generated with patch-builder.py
