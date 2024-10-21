; md5 9627134ca3ea6e885275d30460ce3563

; ROMBANKS 4
; ROM "Burger Time Deluxe (JU) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffb3
DEF joypad_2 EQU $ffb2
DEF current_rom_bank EQU $ffc7


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$0061] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$027f] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $02b3
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7C38], BANK[$0003] ; length: $300
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
