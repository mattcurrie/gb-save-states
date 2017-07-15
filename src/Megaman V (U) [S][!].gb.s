; md5 ceb17d831b410d91aa41bf2819cbed82

.INCLUDE "includes/init.s"
.ROMBANKS 32
.BACKGROUND "Megaman V (U) [S][!].gb"
.INCLUDE "includes/header.s"


;**********
;* config *
;**********

.DEFINE joypad $de91
.DEFINE joypad_2 $de92
.DEFINE current_rom_bank $df00
.DEFINE current_nr34_value $dc7b


;*************************
;* relocated joypad read *
;*************************

.BANK $00 SLOT 0
.ORG $0023
.SECTION "call mbc1 fix" SIZE 3 OVERWRITE
    call mbc1_on_mbc5_fix
.ENDS

.ORG $3f80
.SECTION "relocated read from joypad" SIZE $80 OVERWRITE
    .INCLUDE "includes/relocated_read_from_joypad.s"

    ; prevent selecting rom bank 0 
    mbc1_on_mbc5_fix:
        push af                    
        or a                   
        jr nz,mbc1_on_mbc5_fix_skip
        inc a                      
    mbc1_on_mbc5_fix_skip:    
        ld ($2100),a               
        pop af                     
        ret   
.ENDS


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $18ba
.SECTION "joypad read" SIZE 4 OVERWRITE   
    call relocated_read_from_joypad
    nop
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3d80
.SECTION "save/load state" SIZE $280 OVERWRITE
    .DB "--- Megaman 5 Save Patch ---"
    .INCLUDE "includes/save_state_includes.s"
.ENDS
