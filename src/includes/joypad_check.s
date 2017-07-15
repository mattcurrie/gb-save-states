; The following defines are required:
; .DEFINE joypad $ff00+$8b
; .DEFINE current_rom_bank $7fff
;
; Optional:
;.DEFINE joypad_2 joypad+1
;.DEFINE swap_joypad 1
;.DEFINE dont_save_interrupt_flags 1


joypad_check:

.IFDEF preserve_registers
    push af
    push bc
    push de
    push hl
.ENDIF

    ; read value of joypad
    ld a,(joypad)
.IFDEF swap_joypad
    swap a
.ENDIF
.IFDEF cpl_joypad
    cpl
.ENDIF

    ; copy joypad value into C register
    ld c,a

    and $0c                     ; check start or select is pressed

.IFNDEF preserve_registers 
    ret z
.ELSE
    jr z, restore_registers
.ENDIF


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
        ld a,(current_rom_bank)
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



            ; store the response code for later
            ld b,a

.IFDEF current_rom_bank
.IFNDEF already_changed_rom_bank
        ; restore previous ROM bank
        pop af
        ld ($2000),a
.ENDIF
.ENDIF

    ; check the response code to see if loaded/saved a game 
    ld a,b
    cp 0
    jr z,save_or_load_continue

    ; clear the joypad state - prevents the game from pausing
    xor a

.IFDEF cpl_joypad
    cpl
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


.IFDEF preserve_registers
restore_registers:
    pop hl
    pop de
    pop bc
    pop af
.ENDIF

    ret

start_pressed_end: