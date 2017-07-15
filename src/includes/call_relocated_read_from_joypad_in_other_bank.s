.DEFINE interrupts_already_disabled 1
.DEFINE already_changed_rom_bank 1


.IFDEF preserve_register_a
    ld b,a
.ENDIF

    ; disable interrupts
    ld a,($ff00+$ff)   
    push af            
    xor a              
    ld ($ff00+$ff),a   

    ; save current ROM bank
    ld a,(current_rom_bank)
    push af

    ld a,:relocated_read_from_joypad
    ld ($2000),a

.IFDEF preserve_register_a
    ld a,b
.ENDIF

    call relocated_read_from_joypad

    ; restore previous ROM bank
    pop af
    ld ($2000),a


    ; enable interrupts
    pop af
    ld ($ff00+$ff),a