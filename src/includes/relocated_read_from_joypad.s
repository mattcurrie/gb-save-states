; The following defines are required:
; .DEFINE joypad $ff00+$8b
; .DEFINE current_rom_bank $7fff
;
; Optional:
;.DEFINE joypad_2 joypad+1
;.DEFINE swap_joypad 1
;.DEFINE dont_save_interrupt_flags 1

relocated_read_from_joypad:


.IFDEF joypad_debounce
    ld c,a           
    ld a,(joypad)
    xor c            
    and c            
    ld (joypad_2),a     
    ld a,c           
    ld (joypad),a
.ENDIF


.IFNDEF joypad_read_already_finished
    ; finish off the joypad function
    ld a,$30
    ld ($ff00+$00),a
.ENDIF



.INCLUDE "includes/joypad_check.s"

relocated_read_from_joypad_end:
