; md5 d5c27ff8cb1b69cb56df4ff170e2baf0

; ROMBANKS 16
; ROM "Final Fantasy Legend, The (U) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ff8b
DEF game_uses_save_ram EQU 1


;**********
;* joypad *
;**********

DEF joypad EQU $ff8d

SECTION "joypad read", ROM0[$06f7] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $0717
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02c5
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
