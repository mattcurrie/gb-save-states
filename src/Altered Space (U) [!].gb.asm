; md5 012ee0a196c03cca91a43a9eadbecfb6

; ROMBANKS 16
; ROM "Altered Space (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c07a
DEF joypad_2 EQU $c07b
DEF current_rom_bank EQU $c0c7


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0964

SECTION "reset ram", ROM0[$00dc] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$06cd] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $0700
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
