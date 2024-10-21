; md5 2eb9a6891fc79cd878d8bc12d04a0790

; ROMBANKS 8
; ROM "Dynablaster (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$8a
DEF joypad_2 EQU $ff00+$8b
DEF current_rom_bank EQU $ff00+$c6
DEF current_nr34_value EQU $d82a


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    DEF preserve_registers EQU 1
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$04d3] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$5000], BANK[$01] ; length: $500
    DB "--- Dynablaster Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
