; md5 1f8089ca53d6e9aff6d1907710d28bc8

; ROMBANKS 8
; ROM "Heavyweight Championship Boxing (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $df09
DEF joypad_2 EQU $df0a
DEF current_rom_bank EQU $4000


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00a3] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "relocated read from joypad", ROM0[$0062] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2748] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$4001], BANK[$0004] ; length: $0220
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION

SECTION "new bank", ROMX[$4000], BANK[$0004] ; length: 1
    DB $4
ENDSECTION


; Generated with patch-builder.py
