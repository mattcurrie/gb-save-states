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