;***************************************************************************;
;
; Calls the relocated_read_from_joypad fuction in a different ROM bank, 
; restoring the previous ROM bank afterwards.
;
;***************************************************************************

invoke_relocated_read_from_joypad_in_other_bank_part_2:

IF DEF(preserve_register_a)
    ld a,b
ENDC

    call relocated_read_from_joypad

IF DEF(current_rom_bank)
    ; restore previous ROM bank
    pop af
    ld [$2000],a
ENDC


IF !DEF(calling_from_vblank)
    ; enable interrupts
    pop af
    ld [$ff00+$ff],a
ENDC
