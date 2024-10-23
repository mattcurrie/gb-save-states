;***************************************************************************
; 
; Reads the current joypad state into joypad (and joypad_2/joypad_3 if
; defined) and then checks if the button combos are pressed
;
;***************************************************************************

relocated_read_from_joypad:

IF DEF(calling_from_vblank)

    push bc
    push de
    push hl

    ld a,$0a  ; enable access to ram bank
    ld [ram_access_toggle],a

    ; select the ram bank we need for writing the joypad value
    ld a,[SAVE_STATE_RAM_BANK]
    ld [ram_bank_select],a

ENDC



INCLUDE "includes/joypad_read.asm"      


IF DEF(joypad_2)

    ld a,[joypad]
    xor c            
    and c            
    ld [joypad_2],a     
IF DEF(joypad_4)
    ld [joypad_4],a     
ENDC

    ld a,c           
ENDC    

IF DEF(joypad_3)
    ld [joypad_3],a     
ENDC

    ld [joypad],a     
    ld a,$30         
    ld [$ff00+$00],a 


INCLUDE "includes/joypad_check.asm"


IF DEF(calling_from_vblank)

    IF DEF(game_uses_save_ram)
        ; restore sram bank
        IF DEF(current_sram_bank)
            ld a, [current_sram_bank]
        ELSE
            xor a
        ENDC
        ld [ram_bank_select],a
    ELSE
        ; lock access to ram bank
        xor a  
        ld [ram_access_toggle],a
    ENDC

    pop hl
    pop de
    pop bc

ENDC

    ret
