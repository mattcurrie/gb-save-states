; md5 4bd6e929ec716a5c7fe7dc684860d551

; ROMBANKS 32
; ROM "Super Mario Land 2 - 6 Golden Coins (UE) (V1.2) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$80
DEF joypad_2 EQU $ff00+$81
DEF current_rom_bank EQU $a24e
DEF current_nr34_value EQU $a43a
DEF game_uses_save_ram EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$1fda] ; length: $34
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7800], BANK[$1d] ; length: $600
    DB "--- Super Mario Land 2 Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
