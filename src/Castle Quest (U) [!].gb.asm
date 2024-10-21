; md5 03ce24437224ff296a71f402663a0ee9

; ROMBANKS 8
; ROM "Castle Quest (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffd9
DEF current_rom_bank EQU $c000


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0029] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$01d2] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $01fa
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7B04], BANK[$0002] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
