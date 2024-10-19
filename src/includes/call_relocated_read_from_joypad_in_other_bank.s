;***************************************************************************;
;
; Calls the relocated_read_from_joypad fuction in a different ROM bank, 
; restoring the previous ROM bank afterwards.
;
;***************************************************************************

.IFNDEF do_not_disable_interrupts
    .DEFINE interrupts_already_disabled 1
.ENDIF
.DEFINE already_changed_rom_bank 1


invoke_relocated_read_from_joypad_in_other_bank:


.IFDEF preserve_register_a
    ld b,a
.ENDIF


.IFNDEF calling_from_vblank
.IFNDEF do_not_disable_interrupts
    ; disable interrupts
    ld a,($ff00+$ff)   
    push af            
    xor a              
    ld ($ff00+$ff),a   
.ENDIF
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
    .IFDEF set_current_rom_bank
        ld (current_rom_bank), a
    .ENDIF
    ld ($2000),a
.ENDIF

.IFDEF preserve_register_a
    ld a,b
.ENDIF

    call relocated_read_from_joypad

.IFDEF current_rom_bank
    ; restore previous ROM bank
    pop af
    .IFDEF set_current_rom_bank
        ld (current_rom_bank), a
    .ENDIF
    ld ($2000),a
.ENDIF


.IFNDEF calling_from_vblank
.IFNDEF do_not_disable_interrupts
    ; enable interrupts
    pop af
    ld ($ff00+$ff),a
.ENDIF
.ENDIF

