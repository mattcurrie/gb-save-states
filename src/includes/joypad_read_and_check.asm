;***************************************************************************
; 
; Reads the current joypad state into joypad (and joypad_2/joypad_3 if
; defined) and then checks if the button combos are pressed
;
;***************************************************************************

relocated_read_from_joypad:

.IFDEF calling_from_vblank

    push bc
    push de
    push hl

    ld a,$0a  ; enable access to ram bank
    ld (ram_access_toggle),a

    ; select the ram bank we need for writing the joypad value
    ld a,(SAVE_STATE_RAM_BANK)
    ld (ram_bank_select),a

.ENDIF



.INCLUDE "includes/joypad_read.s"      


.IFDEF joypad_2

    ld a,(joypad)
    xor c            
    and c            
    ld (joypad_2),a     
.IFDEF joypad_4
    ld (joypad_4),a     
.ENDIF

    ld a,c           
.ENDIF    

.IFDEF joypad_3
    ld (joypad_3),a     
.ENDIF

    ld (joypad),a     
    ld a,$30         
    ld ($ff00+$00),a 


.INCLUDE "includes/joypad_check.asm"


.IFDEF calling_from_vblank

    .IFDEF game_uses_save_ram
        ; restore sram bank
        .IFDEF current_sram_bank
            ld a, (current_sram_bank)
        .ELSE
            xor a
        .ENDIF
        ld (ram_bank_select),a
    .ELSE
        ; lock access to ram bank
        xor a  
        ld (ram_access_toggle),a
    .ENDIF

    pop hl
    pop de
    pop bc

.ENDIF

    ret