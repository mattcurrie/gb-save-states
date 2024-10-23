; md5 ddb5bfae32b0ca39cf8ab6c46880126c

; ROMBANKS 64
; ROM "Kirby's Dream Land 2 (U) [S][!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ffc0        ; these bytes appear to be unused
DEF joypad_2 EQU $ffc1

DEF current_rom_bank EQU $ffa4
DEF game_uses_save_ram EQU 1
DEF calling_from_vblank EQU 1
DEF uses_mbc5 EQU 1
DEF current_nr34_value EQU $ce14


;*************************
;* relocated joypad read *
;*************************

SECTION "vblank", ROM0[$0044] ; length: $3
    jp invoke_relocated_read_from_joypad_in_other_bank
ENDSECTION

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $0159
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$20] ; length: $4000
    DB "--- Kirby's Dream Land 2 Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
