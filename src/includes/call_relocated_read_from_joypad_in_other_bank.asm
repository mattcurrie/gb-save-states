;***************************************************************************;
;
; Calls the relocated_read_from_joypad fuction in a different ROM bank, 
; restoring the previous ROM bank afterwards.
;
;***************************************************************************

IF !DEF(do_not_disable_interrupts)
    DEF interrupts_already_disabled EQU 1
ENDC
DEF already_changed_rom_bank EQU 1


invoke_relocated_read_from_joypad_in_other_bank:


IF DEF(preserve_register_a)
    ld b,a
ENDC


IF !DEF(calling_from_vblank)
IF !DEF(do_not_disable_interrupts)
    ; disable interrupts
    ldh a,[$ff00+$ff]   
    push af            
    xor a              
    ldh [$ff00+$ff],a   
ENDC
ENDC

IF DEF(current_rom_bank)
    ; save current ROM bank
    IF !DEF(should_detect_rom_bank)
        ld a,[current_rom_bank]
    ELSE
        detect_rom_bank
    ENDC
    push af

    ld a,BANK(relocated_read_from_joypad)
    IF DEF(set_current_rom_bank)
        ld [current_rom_bank],a
    ENDC
    ld [$2000],a
ENDC

IF DEF(preserve_register_a)
    ld a,b
ENDC

    call relocated_read_from_joypad

IF DEF(current_rom_bank)
    ; restore previous ROM bank
    pop af
    IF DEF(set_current_rom_bank)
        ld [current_rom_bank],a
    ENDC
    ld [$2000],a
ENDC


IF !DEF(calling_from_vblank)
IF !DEF(do_not_disable_interrupts)
    ; enable interrupts
    pop af
    ld [$ff00+$ff],a
ENDC
ENDC
