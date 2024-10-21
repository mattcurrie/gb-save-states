;**********
;* vblank *
;**********

DEF calling_from_vblank EQU 1
DEF interrupts_already_disabled EQU 1
DEF already_changed_rom_bank EQU 1

DEF joypad EQU $BFE8
DEF joypad_2 EQU $BFE9

SECTION "vblank", ROM0[$0040] ; length: $8
    
    push af

    ; select the joypad buttons
    ld a,$10
    ldh [$00],a

    jp vblank_handler

ENDSECTION

SECTION "vblank handler", ROM0[vblank_handler] ; length: $22

    IF DEF(current_rom_bank)
        ; change the rom bank while waiting for joypad lines to settle
       
        ; save current ROM bank
        IF !DEF(should_detect_rom_bank)
            ld a,[current_rom_bank]
        ELSE
            detect_rom_bank
        ENDC
        push af

        ; set the required rom bank
        ld a,BANK(relocated_read_from_joypad)
        ld [$2000],a

    ELSE

        ; wait for joypad lines to settle
        push hl
        pop hl
        push hl
        pop hl

    ENDC

    ; read joypad and check for start or select being pressed
    ldh a,[$00]
    cpl
    and $0c
    call nz,relocated_read_from_joypad


    IF DEF(current_rom_bank)
        ; restore previous ROM bank
        pop af
        ld [$2000],a
    ENDC

    ; reset joypad
    ld a,$30
    ldh [$00],a

    pop af

IF DEF(original_vblank_handler_pushes)
    
    original_vblank_handler_pushes_macro

ENDC

IF DEF(use_call_for_original_vblank_handler)
    call original_vblank_handler
ELSE
    jp original_vblank_handler
ENDC


ENDSECTION
