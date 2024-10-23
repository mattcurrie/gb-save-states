;***************************************************************************;
;
; Calls the relocated_read_from_joypad fuction in a different ROM bank, 
; restoring the previous ROM bank afterwards.
;
;***************************************************************************

DEF interrupts_already_disabled EQU 1
DEF already_changed_rom_bank EQU 1


invoke_relocated_read_from_joypad_in_other_bank:


IF DEF(preserve_register_a)
    ld b,a
ENDC


IF !DEF(calling_from_vblank)
    ; disable interrupts
    ldh a,[$ff00+$ff]   
    push af            
    xor a              
    ldh [$ff00+$ff],a   
ENDC

IF DEF(current_rom_bank)
    ; save current ROM bank
    ld a,[current_rom_bank]
    push af

    ld a,BANK(relocated_read_from_joypad)
    ld [$2000],a
ENDC

    jp invoke_relocated_read_from_joypad_in_other_bank_part_2
