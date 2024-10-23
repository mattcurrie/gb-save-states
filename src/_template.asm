; md5 insert-md5-hash

; ROMBANKS insert-number-of-banks
; ROM "insert-rom-file-name"


;**********
;* config *
;**********

DEF joypad EQU $tttt
DEF joypad_2 EQU $ssss
DEF current_rom_bank EQU $iiii


;*************************
;* relocated joypad read *
;*************************

SECTION "relocated read from joypad", ROM0[$0080] ; length: $70
    INCLUDE "includes/relocated_read_from_joypad.asm"
    INCLUDE "includes/reset_ram.asm"
ENDSECTION


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

SECTION "joypad read", ROM0[$qqqq] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

.BANK $zz SLOT 1
SECTION "save/load state", ROM0[$xxxx] ; length: 4
    DB "--- XXXXX Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
