; md5 7c65e9da405d2225d079f75e56276822

; ROMBANKS 16
; ROM "Castlevania II - Belmont's Revenge (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c886
DEF joypad_2 EQU $c887
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $7fff
DEF current_nr34_value EQU $c1c4
DEF restore_sound EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$3503] ; length: $33
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$8] ; length: $4000
    DB "--- Castlevania 2 Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
