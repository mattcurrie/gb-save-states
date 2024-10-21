; md5 4c614f884a07872f12056ad1a421e1f9

; ROMBANKS 16
; ROM "Megaman III (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff00+$8a
DEF joypad_2 EQU $ff00+$8b
DEF current_rom_bank EQU $de93


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$3fa0] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$14df] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D1D], BANK[$01] ; length: $2e3
    DB "--- Megaman 3 Save Patch v1.0 ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
