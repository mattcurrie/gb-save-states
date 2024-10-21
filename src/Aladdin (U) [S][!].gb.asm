; md5 ed5525a71dda6eaf4bbf8d5601b6b3b9

; ROMBANKS 32
; ROM "Aladdin (U) [S][!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c280
DEF current_rom_bank EQU $ddfa


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $01da

SECTION "reset ram", ROM0[$0059] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0000] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$04ae] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0010] ; length: $220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
