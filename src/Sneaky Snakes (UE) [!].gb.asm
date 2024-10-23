; md5 0b5127a54cc8581acfabe0413378ca3d

; ROMBANKS 8
; ROM "Sneaky Snakes (UE) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ffc4


;**********
;* joypad *
;**********

DEF joypad EQU $ff8f
DEF joypad_2 EQU $ff90

SECTION "joypad read", ROM0[$2ee2] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7639], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
