; md5 cb0a5d103c01d1d82d324602a45dd21b

; ROMBANKS 8
; ROM "Burning Paper (J).gb"


;**********
;* config *
;**********

DEF joypad EQU $ffb6
DEF joypad_2 EQU $ffb8
DEF current_rom_bank EQU $ffe3
DEF restore_wave_ram EQU 1


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROMX[$5D88], BANK[$01] ; length: 4
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7000], BANK[$7] ; length: $1000
    DB "--- Burning Paper Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
