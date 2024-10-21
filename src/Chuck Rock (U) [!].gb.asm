; md5 435b566a4b3745b0acc5a976bedd9245

; ROMBANKS 16
; ROM "Chuck Rock (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffae
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $ffb1


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $019a

SECTION "reset ram", ROM0[$00d5] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0095] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$08f8] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
