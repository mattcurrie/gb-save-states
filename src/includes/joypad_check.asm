;***************************************************************************
;
; Checks to see if start or select are pressed. If so, then it will call a
; function to check whether any of button combos are pressed.
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
; DEF dont_save_interrupt_flags EQU 1
; DEF preserve_registers EQU 1
; DEF interrupts_already_disabled EQU 1
; DEF already_changed_rom_bank EQU 1
; DEF read_joypad_value_from_b_register EQU 1
;
;***************************************************************************

joypad_check:

IF DEF(preserve_registers)
    push af
    push bc
    push de
    push hl
ENDC

    ; read value of joypad
IF DEF(read_joypad_value_from_b_register)
    ld a, b
ELSE
    ld a,[joypad]
ENDC
IF DEF(swap_joypad)
    swap a
ENDC
IF DEF(cpl_joypad)
    cpl
ENDC

    ; copy joypad value into C register
    ld c,a

    and $0c                     ; check start or select is pressed

    jr z, joypad_check_end


start_pressed:

IF !DEF(interrupts_already_disabled)
    ; save the currently enabled interrupts and then disable all
    ldh a,[$ff00+$ff]   
    push af            
    xor a              
    ldh [$ff00+$ff],a   
ENDC

IF !DEF(dont_save_interrupt_flags)
    ; read current interrupt flag
    ldh a,[$ff00+$0f]
    push af
ENDC


IF DEF(current_rom_bank)
IF !DEF(already_changed_rom_bank)
        ; save current ROM bank
        IF !DEF(should_detect_rom_bank)
            ld a,[current_rom_bank]
        ELSE
            detect_rom_bank
        ENDC
        push af
ENDC
ENDC


IF DEF(current_rom_bank)
IF !DEF(already_changed_rom_bank)
            ld a,BANK(CHECK_FOR_SAVE_OR_LOAD_GAME)
            ld [$2000],a
ENDC
ENDC

IF DEF(check_for_save_or_load_via_bank_0)
            call CHECK_FOR_SAVE_OR_LOAD_GAME_VIA_BANK_0
ELSE
            call CHECK_FOR_SAVE_OR_LOAD_GAME
ENDC




IF DEF(current_rom_bank)
IF !DEF(already_changed_rom_bank)

        ; store the response code for later
        ld c,a

        ; restore previous ROM bank
        pop af
        ld [$2000],a

        ; restore the response code
        ld a,c
ENDC
ENDC


    ; check the response code to see if loaded/saved a game 
    or a    ; cp 0
    jr z,save_or_load_continue

    ; clear the joypad state - prevents the game from pausing
    xor a

IF DEF(cpl_joypad)
    cpl
ENDC

IF DEF(read_joypad_value_from_b_register)
    ld b, a
ENDC

    ld [joypad],a
IF DEF(joypad_2)
    ld [joypad_2],a
ENDC
IF DEF(joypad_3)
    ld [joypad_3],a
ENDC


save_or_load_continue:

IF !DEF(dont_save_interrupt_flags)
    ; restore old interrupt flag value off the stack
    pop af
    ldh [$ff00+$0f],a
ENDC
 
IF !DEF(interrupts_already_disabled)
    ; enable interrupts - pop value for IE register from stack
    pop af
    ldh [$ff00+$ff],a   
ENDC

joypad_check_end:

IF DEF(preserve_registers)
restore_registers:
    pop hl
    pop de
    pop bc
    pop af
ENDC


start_pressed_end:
