; md5 0c7beead4f65e97a23b718ce20a1bf55

; ROMBANKS 8
; ROM "Brain Drain (U) [S][!].gb"


;**********
;* config *
;**********

; MANUAL EDIT - joypad detected incorrectly
DEF joypad EQU $ff8a
DEF joypad_2 EQU $ff8b

DEF current_rom_bank EQU $ff9f


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a1] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0061] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

; MANUAL EDIT - wrong value for .ORG directive
SECTION "joypad read", ROM0[$039d] ; length: 3
    call relocated_read_from_joypad
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$5A58], BANK[$0007] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
