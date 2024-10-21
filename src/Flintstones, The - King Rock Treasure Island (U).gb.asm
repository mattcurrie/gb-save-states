; md5 25dfaca5120462af05532aaf4756776a

; ROMBANKS 16
; ROM "Flintstones, The - King Rock Treasure Island (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ffa6
DEF joypad_2 EQU $ffa7
DEF current_rom_bank EQU $7fff


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0380] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $03b0
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
