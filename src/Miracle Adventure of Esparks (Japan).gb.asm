; md5 64080619789f154ee057f2946a98c61c

; ROMBANKS 16
; ROM "Miracle Adventure of Esparks (Japan).gb"


;**********
;* config *
;**********

DEF joypad EQU $fffa
DEF joypad_2 EQU $fffb
DEF current_rom_bank EQU $ffc7

;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$5] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$08] ; length: $0255
    DB "--- XXXXX Save Patch ---"
	INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
