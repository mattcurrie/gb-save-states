; md5 7d776329212fa7cc2b00c5a46f06dd92

; ROMBANKS 16
; ROM "Darkwing Duck (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff92
DEF joypad_2 EQU $ff93
DEF current_rom_bank EQU $ff98

;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$00C0] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0381] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$08] ; length: $4000
    DB "--- Darkwing Duck Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
