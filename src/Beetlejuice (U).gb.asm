; md5 f6c1715b8b93356b8b8ad27f5574dc96

; ROMBANKS 16
; ROM "Beetlejuice (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $c939
DEF joypad_2 EQU $c93a
DEF current_rom_bank EQU $7fff


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$3de6] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $3e19
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$7FFF], BANK[$0008] ; length: 1
    DB $8
ENDSECTION


; Generated with patch-builder.py
