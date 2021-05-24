;***************************************************************************;
;
; Calls the relocated_read_from_joypad fuction in a different ROM bank, 
; restoring the previous ROM bank afterwards.
;
;***************************************************************************

.DEFINE interrupts_already_disabled 1
.DEFINE already_changed_rom_bank 1


invoke_relocated_read_from_joypad_in_other_bank:


.IFDEF preserve_register_a
    ld b,a
.ENDIF


.IFNDEF calling_from_vblank
    ; disable interrupts
    ld a,($ff00+$ff)   
    push af            
    xor a              
    ld ($ff00+$ff),a   
.ENDIF

.IFDEF current_rom_bank
    ; save current ROM bank
    .IFNDEF should_detect_rom_bank
        ld a,(current_rom_bank)
    .ELSE
        detect_rom_bank
    .ENDIF
    push af

    ld a,:relocated_read_from_joypad
    ld ($2000),a
.ENDIF

.IFDEF preserve_register_a
    ld a,b
.ENDIF

    call relocated_read_from_joypad

.IFDEF current_rom_bank
    ; restore previous ROM bank
    pop af
    ld ($2000),a
.ENDIF


.IFNDEF calling_from_vblank
    ; enable interrupts
    pop af
    ld ($ff00+$ff),a
.ENDIF

