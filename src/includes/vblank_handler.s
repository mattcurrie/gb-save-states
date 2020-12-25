;**********
;* vblank *
;**********

.DEFINE calling_from_vblank 1
.DEFINE interrupts_already_disabled 1
.DEFINE already_changed_rom_bank 1

.DEFINE joypad $BFE8
.DEFINE joypad_2 $BFE9

.BANK $00 SLOT 0
.ORG $0040
.SECTION "vblank" SIZE $8 OVERWRITE
    
    push af

    ; select the joypad buttons
    ld a,$10
    ldh ($00),a

    jp vblank_handler

.ENDS

.ORG vblank_handler
.SECTION "vblank handler" SIZE $1D OVERWRITE

    .IFDEF current_rom_bank
        ; change the rom bank while waiting for joypad lines to settle
       
        ; save current ROM bank
        .IFNDEF should_detect_rom_bank
            ld a,(current_rom_bank)
        .ELSE
            detect_rom_bank
        .ENDIF
        push af

        ; set the required rom bank
        ld a,:relocated_read_from_joypad
        ld ($2000),a

    .ELSE

        ; wait for joypad lines to settle
        push hl
        pop hl
        push hl
        pop hl

    .ENDIF

    ; read joypad and check for start or select being pressed
    ldh a,($00)
    cpl
    and $0c
    call nz,relocated_read_from_joypad


    .IFDEF current_rom_bank
        ; restore previous ROM bank
        pop af
        ld ($2000),a
    .ENDIF

    ; reset joypad
    ld a,$30
    ldh ($00),a

    pop af

.IFDEF original_vblank_handler_pushes
    
    .DB original_vblank_handler_pushes

.ENDIF

.IFDEF use_call_for_original_vblank_handler
    call original_vblank_handler
.ELSE
    jp original_vblank_handler
.ENDIF


.ENDS
