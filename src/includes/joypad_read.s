;***************************************************************************
;
; Reads the current joypad state
;
; OUTPUT:
; C = current state of the joypad
;
;***************************************************************************

relocated_read_from_joypad:

    ld a,$20                    
    ld ($ff00+$00),a            
    ld a,($ff00+$00)
    ld a,($ff00+$00)
    cpl              
    and $0f          
    swap a           
    ld b,a           
    ld a,$10         
    ld ($ff00+$00),a 
    ld a,($ff00+$00)
    ld a,($ff00+$00)
    ld a,($ff00+$00)
    ld a,($ff00+$00)
    ld a,($ff00+$00)
    ld a,($ff00+$00)
    cpl              
    and $0f          
    or b             

.IFDEF swap_joypad
    swap a
.ENDIF
.IFDEF cpl_joypad
    cpl
.ENDIF


    ld c,a
    