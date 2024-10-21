; md5 ff9196caa266ae36d409ce7e53ddc77a

; ROMBANKS 32
; ROM "Another Bible (J) [S].gb"


;**********
;* config *
;**********

DEF joypad EQU $c001
DEF joypad_2 EQU $c002
DEF current_rom_bank EQU $c077
DEF game_uses_save_ram EQU 1


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00c4] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0681] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7B45], BANK[$0001] ; length: $02c5
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
