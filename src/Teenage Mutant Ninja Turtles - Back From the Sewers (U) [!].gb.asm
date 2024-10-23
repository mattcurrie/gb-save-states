; md5 0221de99d11f50f79430c8ff9b430994

; ROMBANKS 32
; ROM "Teenage Mutant Ninja Turtles - Back From the Sewers (U) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $c7a7


;**********
;* joypad *
;**********

DEF joypad EQU $c78e
DEF joypad_2 EQU $c78f
DEF swap_joypad EQU 1

SECTION "relocated read from joypad", ROM0[$00be] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$083b] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0010] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
