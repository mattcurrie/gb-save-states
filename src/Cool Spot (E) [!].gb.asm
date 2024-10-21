; md5 1ddff2c150456069776f8c79671cb9f7

; ROMBANKS 16
; ROM "Cool Spot (E) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $ff8a
DEF swap_joypad EQU 1
DEF current_rom_bank EQU $db4f


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00dc] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$0bd2] ; length: $20
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"

    ; MANUAL EDIT - joypad state must be copied into D register after reading
    ld a,[$ff8a]
    ld d,a

    jp $0bfb
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$0008] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
