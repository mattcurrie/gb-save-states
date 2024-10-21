; md5 05ba7f165dab1ffd49b63b4f5c704c02

; ROMBANKS 8
; ROM "Faceball 2000 (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c901
DEF current_rom_bank EQU $ff80


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $09b1

SECTION "reset ram", ROM0[$0065] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$14bb] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$5DB5], BANK[$0002] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
