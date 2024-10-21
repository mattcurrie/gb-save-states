; md5 70a9ef90ad443881ca90cdd8d910ae66

; ROMBANKS 8
; ROM "Sagaia (Japan).gb"


;**********
;* config *
;**********

DEF joypad EQU $c018
DEF joypad_2 EQU $c019
DEF current_rom_bank EQU $c013


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$70] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
    ret
ENDSECTION

;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$1384] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7310], BANK[$07] ; length: $0255
    DB "--- XXXXX Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
