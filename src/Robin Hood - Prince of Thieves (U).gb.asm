; md5 2815ff13131712bcd00c3852d461b414

; ROMBANKS 16
; ROM "Robin Hood - Prince of Thieves (U).gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $fffe


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0070

SECTION "reset ram", ROM0[$0029] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* joypad *
;**********

DEF joypad EQU $d053
DEF joypad_2 EQU $d054

SECTION "joypad read", ROM0[$0e8d] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $0ec1
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7339], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
