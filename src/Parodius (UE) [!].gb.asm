; md5 c94afb46cada0118aa8ff08cc07749a4

; ROMBANKS 16
; ROM "Parodius (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $cb86
DEF joypad_2 EQU $cb87
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $7fff
DEF current_nr34_value EQU $c1b6


;*************************
;* relocated joypad read *
;*************************

SECTION "will read from joypad", ROM0[$00a0] ; length: $60
    will_read_from_joypad:
        call $4087
        INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
        ret
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$02fd] ; length: 3
    call will_read_from_joypad
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D10], BANK[$0e] ; length: $25f
; no space    DB "--- Parodius Save Patch ---"
    DEF joypad_read_already_finished EQU 1
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
