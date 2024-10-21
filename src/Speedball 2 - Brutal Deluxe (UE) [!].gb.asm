; md5 d7fb01dec29a52de74e5b335b8619e0a

; ROMBANKS 8
; ROM "Speedball 2 - Brutal Deluxe (UE) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffd2
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $ffd5


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0b89

SECTION "reset ram", ROM0[$001d] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0e09] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$64C2], BANK[$0007] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
