; md5 1c94dccdfaaa0c3e1d6bda5969704885

; ROMBANKS 4
; ROM "Qix (JU) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ff8f


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$001c] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* joypad *
;**********

DEF joypad EQU $ff8a
DEF joypad_2 EQU $ff8b

SECTION "joypad read", ROM0[$2bf8] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $2c28
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7A8B], BANK[$0002] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
