; md5 1efea4210026a8d733a5b2ade2b005f1

; ROMBANKS 8
; ROM "Ikari no Yousai 2 (J) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $7fff


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00c1] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* joypad *
;**********

DEF joypad EQU $ffdd
DEF joypad_2 EQU $ffde

SECTION "relocated read from joypad", ROM0[$0071] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$034e] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$76B1], BANK[$0001] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
