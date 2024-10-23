; md5 db156bc96b528996ce1bf771195171af

; ROMBANKS 32
; ROM "Final Fantasy Legend III (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8a
DEF joypad_2 EQU $ff8b
DEF current_rom_bank EQU $c0b1
DEF game_uses_save_ram EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$36f6] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0010] ; length: $02c5
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
