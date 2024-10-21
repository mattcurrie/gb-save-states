;***************************************************************************
;
; Resets the internal RAM at startup. Requires a RESET_RAM_DONE label to
; be added somewhere.
;
;***************************************************************************

RESET_RAM:
    
    ; preserve the value of the a register
    ld b,a

    ld hl,$c000
    ld a,$ff

RESET_RAM_LOOP:   
    ld  [hl+],a
    bit 5,h       ; bit 5 will be set when value of h register is $e0

    jr z,RESET_RAM_LOOP

    ; restore the value of the a register
    ld a,b

    jp RESET_RAM_DONE

RESET_RAM_LOOP_END:
