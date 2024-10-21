; md5 6e8166c3783d1807d0a8c3b649e583c1

; ROMBANKS 8
; ROM "Blades of Steel (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $d806
DEF joypad_2 EQU $d807
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $7fff


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0031] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0c33] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $0c6e
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7B84], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
