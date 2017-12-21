;***************************************************************************
;
; Finishes off the joypad read function by writing $30 into $ff00, then
; checks to see if start or select are pressed. If so, then it will call a
; function to check  whether any of button combos are pressed.
;
; The following defines are required:
; .DEFINE joypad $ff00+$8b
;
; Optional:
; .DEFINE current_rom_bank $7fff
; .DEFINE joypad_2 $ff00+$8c
; .DEFINE joypad_3 $ff00+$8d
; .DEFINE swap_joypad 1
; .DEFINE cpl_joypad 1
; .DEFINE joypad_debounce 1
; .DEFINE joypad_read_already_finished 1
; .DEFINE dont_save_interrupt_flags 1
; .DEFINE preserve_registers 1
; .DEFINE interrupts_already_disabled 1
; .DEFINE already_changed_rom_bank 1
;
;***************************************************************************

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

    ret

relocated_read_from_joypad_end:
