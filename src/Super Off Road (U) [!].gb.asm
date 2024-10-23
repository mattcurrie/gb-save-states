; md5 85d05f95c07ed1b7d787062fe4d2e251

; ROMBANKS 8
; ROM "Super Off Road (U) [!].gb"


;**********
;* config *
;**********

DEF joypad EQU $c70b


;*************
;* reset ram *
;*************

DEF RESET_RAM_DONE EQU $0150
SECTION "reset ram jump", ROM0[$0101] ; length: 3
    jp RESET_RAM
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$2c21] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3b00] ; length: $4fd
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/reset_ram.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
