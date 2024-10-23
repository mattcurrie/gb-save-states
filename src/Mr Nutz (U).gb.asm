; md5 7db13139bc32e2aadb732d610f4c1604

; ROMBANKS 16
; ROM "Mr Nutz (U).gb"


;**********
;* config *
;**********

DEF joypad EQU $d8dc
DEF joypad_2 EQU $d8dd
DEF joypad_debounce EQU 1
DEF current_rom_bank EQU $7fff
DEF preserve_register_a EQU 1


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$80] ; length: $80
    INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.asm"
    jp $12a6
ENDSECTION
SECTION "joypad read call", ROM0[$1296] ; length: 3
    jp $0080
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7DA0], BANK[$01] ; length: $260
    DB "--- Mr Nutz Save Patch ---"
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


;*******************
;* bank numbers... *
;*******************

SECTION "bank 1", ROMX[$7FFF], BANK[$01] ; length: 1
    DB $1
ENDSECTION

SECTION "bank 2", ROMX[$7FFF], BANK[$02] ; length: 1
    DB $2
ENDSECTION

SECTION "bank 3", ROMX[$7FFF], BANK[$03] ; length: 1
    DB $3
ENDSECTION

SECTION "bank 4", ROMX[$7FFF], BANK[$04] ; length: 1
    DB $4
ENDSECTION

SECTION "bank 5", ROMX[$7FFF], BANK[$05] ; length: 1
    DB $5
ENDSECTION

SECTION "bank 6", ROMX[$7FFF], BANK[$06] ; length: 1
    DB $6
ENDSECTION

SECTION "bank 7", ROMX[$7FFF], BANK[$07] ; length: 1
    DB $7
ENDSECTION

SECTION "bank 8", ROMX[$7FFF], BANK[$08] ; length: 1
    DB $8
ENDSECTION

SECTION "bank 9", ROMX[$7FFF], BANK[$09] ; length: 1
    DB $9
ENDSECTION

SECTION "bank a", ROMX[$7FFF], BANK[$0a] ; length: 1
    DB $a
ENDSECTION

SECTION "bank b", ROMX[$7FFF], BANK[$0b] ; length: 1
    DB $b
ENDSECTION

SECTION "bank c", ROMX[$7FFF], BANK[$0c] ; length: 1
    DB $c
ENDSECTION

SECTION "bank d", ROMX[$7FFF], BANK[$0d] ; length: 1
    DB $d
ENDSECTION

SECTION "bank e", ROMX[$7FFF], BANK[$0e] ; length: 1
    DB $e
ENDSECTION

SECTION "bank f", ROMX[$7FFF], BANK[$0f] ; length: 1
    DB $f
ENDSECTION
