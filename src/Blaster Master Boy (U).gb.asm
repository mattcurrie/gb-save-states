; md5 c4868bf46a993b4c33a9a8af5341282a

; ROMBANKS 16
; ROM "Blaster Master Boy (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $ffe1
DEF joypad_2 EQU $ffe2
DEF current_rom_bank EQU $c102


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$03be] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $03ee
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
