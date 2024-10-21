;***************************************************************************
;
; Finishes off the joypad read function by writing $30 into $ff00, then
; checks to see if start or select are pressed. If so, then it will call a
; function to check  whether any of button combos are pressed.
;
; The following defines are required:
; DEF joypad EQU $ff00+$8b
;
; Optional:
; DEF current_rom_bank EQU $7fff
; DEF joypad_2 EQU $ff00+$8c
; DEF joypad_3 EQU $ff00+$8d
; DEF swap_joypad EQU 1
; DEF cpl_joypad EQU 1
; DEF joypad_debounce EQU 1
; DEF joypad_read_already_finished EQU 1
; DEF dont_save_interrupt_flags EQU 1
; DEF preserve_registers EQU 1
; DEF interrupts_already_disabled EQU 1
; DEF already_changed_rom_bank EQU 1
;
;***************************************************************************

relocated_read_from_joypad:


IF DEF(joypad_debounce)
    ld c,a           
    ld a,[joypad]
    xor c            
    and c            
    ld [joypad_2],a     
    ld a,c           
    ld [joypad],a
ENDC


IF !DEF(joypad_read_already_finished)
    ; finish off the joypad function
    ld a,$30
    ldh [$ff00+$00],a
ENDC

INCLUDE "includes/joypad_check.asm"

    ret

relocated_read_from_joypad_end:
