; md5 7d76d2a9eaada93dc846efe1b2a815cc

; ROMBANKS 16
; ROM "Kenyuu Densetsu Yaiba (Japan).gb"


;**********
;* config *
;**********

DEF joypad EQU $fffa
DEF joypad_2 EQU $fffb
DEF current_rom_bank EQU $ffc7


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$3ea0] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
    ret
ENDSECTION

;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0af7] ; length: 8
    call relocated_read_from_joypad
    nop
    nop
    nop
    nop
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4C00], BANK[$01] ; length: $300
    DB "--- XXXXX Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
