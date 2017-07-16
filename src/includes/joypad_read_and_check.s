;***************************************************************************
; 
; Reads the current joypad state into joypad (and joypad_2/joypad_3 if
; defined) and then checks if the button combos are pressed
;
;***************************************************************************

.INCLUDE "includes/joypad_read.s"      

.IFDEF joypad_2

    ld a,(joypad)
    xor c            
    and c            
    ld (joypad_2),a     

    ld a,c           
.ENDIF    

.IFDEF joypad_3
    ld (joypad_3),a     
.ENDIF

    ld (joypad),a     
    ld a,$30         
    ld ($ff00+$00),a 


.INCLUDE "includes/joypad_check.s"