; md5 0b4410c6b94d6359dba5609ae9a32909

; ROMBANKS 4
; ROM "Castlevania Adventure, The (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c00c
DEF joypad_2 EQU $c00d
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $7fff
DEF current_nr34_value EQU $c236


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0232] ; length: $33
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************


SECTION "save/load state", ROMX[$7D4E], BANK[$03] ; length: $2B0
    DB "--- Castlevania Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
