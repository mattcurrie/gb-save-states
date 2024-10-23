; md5 8d885e185ad2a0cb5c9e3b152bd24583

; ROMBANKS 16
; ROM "Contra - The Alien Wars (USA) (SGB Enhanced).gb"


;**********
;* config *
;**********

DEF joypad EQU $ffec
DEF joypad_2 EQU $ffeb
DEF read_joypad_value_from_b_register EQU 1
DEF current_rom_bank EQU $ff8c


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$6a] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
    ret
ENDSECTION

;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0744] ; length: 3
    call relocated_read_from_joypad
    ;nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$08] ; length: $0220
    DB "--- XXXXX Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "bank 8", ROMX[$7FFF], BANK[$08] ; length: 1
    DB $8
ENDSECTION
