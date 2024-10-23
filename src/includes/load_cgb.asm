    ; save the current WRAM bank (has been loaded from the save already)
    ldh a, [$70]
    push af

    ; load bg palette
    ld c, $68
    ldh a, [c]
    push af
    ld hl, bg_color_pal_save
    call load_palette
    pop af
    ldh [c], a

    ; load obj palette
    ld c, $6a
    ldh a, [c]
    push af
    ; ld hl, obj_color_pal_save      ; HL already points to this
    call load_palette
    pop af
    ldh [c], a

    ; save the stack pointer we're using internally in SRAM
    ld [internal_stack_pointer_save], sp

    ; update SP to point to top of WRAM bank 0
    ; can use it freely because we're going to overwrite it at the end anyway
    ld sp, $cfff

    ; save current VRAM bank (has been loaded from the save already)
    ldh a, [$4f]
    push af

    ; vram bank 0    
    xor a
    ldh [$4f], a
    ld a, save_state_vram_bank_0
    call copy_sram_to_vram

    ; vram bank 1
    ld a, 1
    ldh [$4f], a
    ld a, save_state_vram_bank_1
    call copy_sram_to_vram

    ; restore VRAM bank
    pop af
    ldh [$4f], a



    ; load wram banks 2-7
    ld a, save_state_wram_bank_23
    ld b, 2
    call load_consecutive_wram_banks

    ld a, save_state_wram_bank_45
    ld b, 4
    call load_consecutive_wram_banks

    ld a, save_state_wram_bank_67
    ld b, 6
    call load_consecutive_wram_banks

    ; restore the save state ram bank.
    ; save state io and stack can now be accessed again
    ld a, [SAVE_STATE_RAM_BANK]
    ld [ram_bank_select], a
    
    ; read wanted speed, and do speedswitch if necessary
    ld a, [io_save + $4d]
    and $80
    ld b, a
    ldh a, [$4d]
    and $80
    xor b   ; result will be non-zero if wanted and current speeds are mis-matched
    jr z, no_speed_toggle
    ; toggle speed
    ld a, 1
    ldh [$4d], a
    stop
no_speed_toggle:


cgb_common_load_save_end:
   
    ; restore wram bank 0 that we've been using for stack, and wram bank 1 too
    ld a, save_state_wram_bank_01
    ld [ram_bank_select], a

    ; select WRAM bank 1
    ld a, 1
    ldh [$70], a

    ld hl, $a000
    ld de, $c000
wram01_restore_loop:    
    ld a, [hl+]
    ld [de], a
    inc de

    ; bit 5 of D will be set when DE = $e000.
    bit 5, d            
    jr z, wram01_restore_loop

    ; restore the save state ram bank (again)
    ; save state io and stack can now be accessed again
    ld a, [SAVE_STATE_RAM_BANK]
    ld [ram_bank_select], a

    ; load the internal stack pointer
    ld a, [internal_stack_pointer_save]
    ld l, a

    ld a, [internal_stack_pointer_save + 1]
    ld h, a

    ld sp, hl

    ; restore the current WRAM bank
    pop af
    ldh [$70], a

    jp RAM_COPY_DONE


; @param a ram bank to read from
; @param b first WRAM bank to load into
load_consecutive_wram_banks:
    ld [ram_bank_select], a

    ; select the wram bank
    ld a, b
    ldh [$70], a
    push af

    ld hl, $a000
    ld de, $d000
    call mem_copy_1000

    ; select the next wram bank
    pop af
    inc a
    ldh [$70], a

    ; ld hl, $b000          ; hl is already $b000 when we reach here
    ld d, $d0               ; de will equal $e000 at this point, so now is $d000
    call mem_copy_1000

    ret


copy_sram_to_vram:
    ld [ram_bank_select],a
    ld hl, $a000
    ld de, $8000
    ld bc, $2000
    jp mem_copy


; Load 64 bytes of palette data
; @param hl palette data source address
; @param c low byte of palette control
; @return hl = hl + 64
; @preserves c
load_palette:
    ld a, $80
    ldh [c], a      ; set auto increment mode
    inc c
    ld b, 64
load_palette_loop:
    ld a, [hl+]     ; read palette
    ldh [c], a      ; write palette and auto increment
    dec b
    jr nz, load_palette_loop
    dec c
    ret
