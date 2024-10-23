; md5 f89a33de3fa660a13ec29bb323efffa9

; ROMBANKS 16
; ROM "Bionic Commando (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c0c0
DEF joypad_2 EQU $c0c1
DEF current_rom_bank EQU $c0d3
DEF current_nr34_value EQU $c47a
DEF restore_sound EQU 1


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$3f00] ; length: $ff
    DEF interrupts_already_disabled EQU 1
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0aef] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION

;*******************
;* save/load state *
;*******************


SECTION "save/load state", ROMX[$7D00], BANK[$0f] ; length: $300
    DB "--- Bionic Commando Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
