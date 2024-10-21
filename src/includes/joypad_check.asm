;***************************************************************************
;
; Checks to see if start or select are pressed. If so, then it will call a
; function to check whether any of button combos are pressed.
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
; .DEFINE dont_save_interrupt_flags 1
; .DEFINE preserve_registers 1
; .DEFINE interrupts_already_disabled 1
; .DEFINE already_changed_rom_bank 1
; .DEFINE read_joypad_value_from_b_register 1
;
;***************************************************************************

joypad_check:

.IFDEF preserve_registers
    push af
    push bc
    push de
    push hl
.ENDIF

    ; read value of joypad
.IFDEF read_joypad_value_from_b_register
    ld a, b
.ELSE
    ld a,(joypad)
.ENDIF
.IFDEF swap_joypad
    swap a
.ENDIF
.IFDEF cpl_joypad
    cpl
.ENDIF

    ; copy joypad value into C register
    ld c,a

    and $0c                     ; check start or select is pressed

    jr z, joypad_check_end


start_pressed:

.IFNDEF interrupts_already_disabled
    ; save the currently enabled interrupts and then disable all
    ld a,($ff00+$ff)   
    push af            
    xor a              
    ld ($ff00+$ff),a   
.ENDIF

.IFNDEF dont_save_interrupt_flags
    ; read current interrupt flag
    ld a,($ff00+$0f)
    push af
.ENDIF


.IFDEF current_rom_bank
.IFNDEF already_changed_rom_bank
        ; save current ROM bank
        .IFNDEF should_detect_rom_bank
            ld a,(current_rom_bank)
        .ELSE
            detect_rom_bank
        .ENDIF
        push af
.ENDIF
.ENDIF


.IFDEF current_rom_bank
.IFNDEF already_changed_rom_bank
            ld a,:CHECK_FOR_SAVE_OR_LOAD_GAME
            ld ($2000),a
.ENDIF
.ENDIF

.IFDEF check_for_save_or_load_via_bank_0
            call CHECK_FOR_SAVE_OR_LOAD_GAME_VIA_BANK_0
.ELSE
            call CHECK_FOR_SAVE_OR_LOAD_GAME
.ENDIF




.IFDEF current_rom_bank
.IFNDEF already_changed_rom_bank

        ; store the response code for later
        ld c,a

        ; restore previous ROM bank
        pop af
        ld ($2000),a

        ; restore the response code
        ld a,c
.ENDIF
.ENDIF


    ; check the response code to see if loaded/saved a game 
    or a    ; cp 0
    jr z,save_or_load_continue

    ; clear the joypad state - prevents the game from pausing
    xor a

.IFDEF cpl_joypad
    cpl
.ENDIF

.IFDEF read_joypad_value_from_b_register
    ld b, a
.ENDIF

    ld (joypad),a
.IFDEF joypad_2
    ld (joypad_2),a
.ENDIF
.IFDEF joypad_3
    ld (joypad_3),a
.ENDIF


save_or_load_continue:

.IFNDEF dont_save_interrupt_flags
    ; restore old interrupt flag value off the stack
    pop af
    ld ($ff00+$0f),a
.ENDIF
 
.IFNDEF interrupts_already_disabled
    ; enable interrupts - pop value for IE register from stack
    pop af
    ld ($ff00+$ff),a   
.ENDIF

joypad_check_end:

.IFDEF preserve_registers
restore_registers:
    pop hl
    pop de
    pop bc
    pop af
.ENDIF


start_pressed_end: