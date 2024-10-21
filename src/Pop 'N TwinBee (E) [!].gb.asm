; md5 05d5cf3404868efc22ac06e22ab5ba89

; ROMBANKS 16
; ROM "Pop 'N TwinBee (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $d806
DEF joypad_2 EQU $d807
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $7fff
DEF restore_wave_ram EQU 1


;*************************
;* relocated joypad read *
;*************************

SECTION "call relocated read from joypad", ROM0[$00b0] ; length: $30
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ret
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROMX[$7112], BANK[$01] ; length: 4
    call invoke_relocated_read_from_joypad_in_other_bank
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$08] ; length: $4000
    DB "--- Pop'n TwinBee Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "bank 8", ROMX[$7FFF], BANK[$08] ; length: 1
    DB $8
ENDSECTION
