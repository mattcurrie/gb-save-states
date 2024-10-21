; md5 2a2ae531b2cebd995508707b0e82b1b1

; ROMBANKS 32
; ROM "B.C. Kid 2 (E) [S].gb"


;**********
;* config *
;**********

DEF joypad EQU $c860
DEF joypad_2 EQU $c861
DEF current_rom_bank EQU $c865
DEF current_nr34_value EQU $dc2a


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$18d4] ; length: $50
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************


SECTION "save/load state", ROMX[$4000], BANK[$10] ; length: $4000
    DB "--- B.C. Kid 2 Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
