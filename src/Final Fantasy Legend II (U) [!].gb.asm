; md5 2bb0df1b672253aaa5f9caf9aab78224

; ROMBANKS 16
; ROM "Final Fantasy Legend II (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff89
DEF current_rom_bank EQU $ff88
DEF game_uses_save_ram EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$172e] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $174e
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4343], BANK[$0001] ; length: $02c5
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
