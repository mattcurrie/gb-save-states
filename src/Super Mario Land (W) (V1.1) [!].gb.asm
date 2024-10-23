; md5 b259feb41811c7e4e1dc200167985c84

; ROMBANKS 4
; ROM "Super Mario Land (W) (V1.1) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$80
DEF joypad_2 EQU $ff00+$81
DEF current_nr34_value EQU $df3a


;*****************************
;* relocated joypad read via *
;*****************************

SECTION "relocated read from joypad via", ROM0[$000b] ; length: $14
    INCLUDE "includes/check_for_save_or_load_via_bank_0.asm"
ENDSECTION


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROMX[$7FB0], BANK[$03] ; length: $30
    DEF check_for_save_or_load_via_bank_0 EQU 1
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;*************
;* reset ram *
;*************

SECTION "reset ram", ROM0[$00f1] ; length: $f
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

DEF RESET_RAM_DONE EQU $0150
SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROMX[$481E], BANK[$03] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7DC5], BANK[$01] ; length: $239
; no space    DB "--- Super Mario Land Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
