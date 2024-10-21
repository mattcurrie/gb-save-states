; md5 69d643bf4e37b3c133518517338b6a1c

; ROMBANKS 32
; ROM "Legend of Zelda, The - Link's Awakening (U) (V1.2) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $dbaf
DEF game_uses_save_ram EQU 1


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150

SECTION "reset ram", ROM0[$00d3] ; length: $F
    INCLUDE "includes/reset_ram.asm"
ENDSECTION

SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;**********
;* joypad *
;**********

DEF joypad EQU $ffcb
DEF joypad_2 EQU $ffcc
DEF swap_joypad EQU 1

SECTION "relocated read from joypad", ROM0[$0092] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2834] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D04], BANK[$0008] ; length: $0245
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
