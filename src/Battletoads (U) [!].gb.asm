; md5 6d24c94d3acd89b4b703f7bd2a504833

; ROMBANKS 16
; ROM "Battletoads (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c903
DEF joypad_2 EQU $c901
DEF current_rom_bank EQU $4000
DEF do_not_disable_interrupts EQU 1

;***************
;* joypad read *
;***************



SECTION "joypad read", ROM0[$32cc] ; length: $33
resume_joypad_read:
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    ld a,[joypad]
    ld c,a
    jr resume_joypad_read
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4000], BANK[$08] ; length: $4000
    DB "--- Battletoads Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "bank 8", ROMX[$7FFF], BANK[$08] ; length: 1
    DB $8
ENDSECTION
