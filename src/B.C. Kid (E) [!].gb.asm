; md5 d335d4d79ed002c7a67863e82ceaa472

; ROMBANKS 32
; ROM "B.C. Kid (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8d
DEF joypad_2 EQU $ff8e
DEF current_rom_bank EQU $c148


;***************
;* joypad read *
;***************

DEF resume_read_from_joypad EQU $0597
SECTION "joypad read", ROM0[$0562] ; length: $34
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ei
    jp resume_read_from_joypad
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$10] ; length: $4000
    DB "--- B.C. Kid Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
