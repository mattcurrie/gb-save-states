; md5 ceb17d831b410d91aa41bf2819cbed82

; ROMBANKS 32
; ROM "Megaman V (U) [S][!].gb"


;**********
;* config *
;**********

DEF joypad EQU $de91
DEF joypad_2 EQU $de92
DEF current_rom_bank EQU $df00
DEF current_nr34_value EQU $dc7b


;*************************
;* relocated joypad read *
;*************************

SECTION "call mbc1 fix", ROM0[$0023] ; length: 3
    call mbc1_on_mbc5_fix
ENDSECTION

SECTION "relocated read from joypad", ROM0[$3f80] ; length: $80
    INCLUDE "includes/relocated_read_from_joypad.asm"

    ; prevent selecting rom bank 0
    mbc1_on_mbc5_fix:
        push af
        or a
        jr nz,mbc1_on_mbc5_fix_skip
        inc a
    mbc1_on_mbc5_fix_skip:
        ld [$2100],a
        pop af
        ret
ENDSECTION


;***************
;* joypad read *
;***************

SECTION "joypad read", ROM0[$18ba] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7D80], BANK[$01] ; length: $280
    DB "--- Megaman 5 Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION
