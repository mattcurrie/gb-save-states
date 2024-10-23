; md5 946a4a60bbd5328ca2250d5f9f0606c7

; ROMBANKS 64
; ROM "Super Mario Land 2 DX - 6 Golden Coins (UE) (V1.0) (V1.8.1).gbc"


;**********
;* config *
;**********

DEF is_cgb EQU 1
DEF current_rom_bank EQU $a24e
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1
DEF restore_wave_ram EQU 1


;**********
;* joypad *
;**********

DEF joypad EQU $ff80
DEF joypad_2 EQU $ff81

SECTION "joypad read", ROM0[$1fd7] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$6541], BANK[$0001] ; length: $0305
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
