; md5 89bb0d67d5af35c2ebf09d9aef2e34ad

; ROMBANKS 64
; ROM "Donkey Kong Land (U) [S][!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ca03
DEF joypad_2 EQU $ca01
DEF current_rom_bank EQU $4000
DEF preserve_registers EQU 1
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1
DEF restore_wave_ram EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$1d86] ; length: $32
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"

    ld a, [$ca03]
    ld c,a
    jp $1db9
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$20] ; length: $4000
    DB $20   ; rom bank number

    DB "--- Donkey Kong Land Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
