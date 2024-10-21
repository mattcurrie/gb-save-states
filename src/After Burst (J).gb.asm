; md5 b5c541c765fd3a5767b3fa1cfc821587

; ROMBANKS 8
; ROM "After Burst (J).gb"


;**********
;* config *
;**********

DEF joypad EQU $c0f1
DEF joypad_2 EQU $c0ef
DEF joypad_3 EQU $c0f0
DEF current_rom_bank EQU $c925


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a3] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0063] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$0387] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0004] ; length: $220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
