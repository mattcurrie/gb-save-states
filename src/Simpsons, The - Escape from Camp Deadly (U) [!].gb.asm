; md5 e731fa23d9cd0c3d4dec7d5565beef61

; ROMBANKS 8
; ROM "Simpsons, The - Escape from Camp Deadly (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8c
DEF current_rom_bank EQU $c698
DEF restore_sound EQU 1


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$00A0] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0cfa] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7940], BANK[$01] ; length: $480
    DB "--- The Simpsons - Escape From Camp Deadly Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
