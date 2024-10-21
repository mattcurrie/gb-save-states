    ; save the current WRAM bank
    ldh a, ($70)
    push af

    ; save bg palette
    ld hl, $ff68
    ld a, (hl)
    push af
    ld de, bg_color_pal_save
    ld c, $69
    call save_palette
    pop af
    ld (hl), a

    ; save obj palette
    ld hl, $ff6a
    ld a, (hl)
    push af
    ; ld de, obj_color_pal_save      ; DE already points to this
    ld c, $6b
    call save_palette
    pop af
    ld (hl), a

    ; save the stack pointer we're using internally in SRAM
    ld (internal_stack_pointer_save), sp

    ; copy WRAM to save state first so we can use it for our purposes
    ld a, save_state_wram_bank_01
    ld (ram_bank_select), a
    
    ; select WRAM bank 1
    ld a, 1
    ldh ($70), a

    ; copy WRAM banks 0 and 1
    ld hl, $c000
    ld de, $a000
wram01_loop:    
    ld a, (hl+)
    ld (de), a
    inc de

    ; bit 6 of D will be set when DE = $c000.
    bit 6, d            
    jr z, wram01_loop

    ; ok WRAM is saved so we can use it freely
    ; update SP to point to top of WRAM bank 0
    ld sp, $cfff

    ; copy remaining wram banks
    ld a, save_state_wram_bank_23
    ld b, 2
    call save_consecutive_wram_banks

    ld a, save_state_wram_bank_45
    ld b, 4
    call save_consecutive_wram_banks

    ld a, save_state_wram_bank_67
    ld b, 6
    call save_consecutive_wram_banks


    ; save current VRAM bank
    ldh a, ($4f)
    push af

    ; vram bank 0    
    xor a
    ldh ($4f), a
    ld a, save_state_vram_bank_0
    call copy_vram_to_sram

    ; vram bank 1
    ld a, 1
    ldh ($4f), a
    ld a, save_state_vram_bank_1
    call copy_vram_to_sram

    ; restore VRAM bank
    pop af
    ldh ($4f), a

    ; restore the save state ram bank.
    ; save state io and stack can now be accessed again
    ld a, (SAVE_STATE_RAM_BANK)
    ld (ram_bank_select), a

    jp cgb_common_load_save_end

; @param a ram bank to write to
; @param b first WRAM bank to copy from
save_consecutive_wram_banks:
    ld (ram_bank_select), a

    ; select the wram bank
    ld a, b
    ldh ($70), a
    push af

    ld hl, $d000
    ld de, $a000
    call mem_copy_1000

    ; select the next wram bank
    pop af
    inc a
    ldh ($70), a

    ld h, $d0               ; hl will equal $e000 at this point, so now is $d000
    ; ld de, $b000          ; de is already $b000 when we reach here
    jp mem_copy_1000


copy_vram_to_sram:
    ld (ram_bank_select),a
    ld hl, $8000
    ld de, $a000
    ld bc, $2000
    jp mem_copy


mem_copy_1000:
    ld bc, $1000

; @param hl source
; @param de destination
; @param bc length
; @return hl = hl + bc, de = de + bc
mem_copy:
    ld a, (hl+)
    ld (de), a
    inc de
    dec bc  
    ld a,b
    or c
    jr nz, mem_copy
    ret

; Save 64 bytes of palette data
; @param hl palette control address
; @param c low byte of palette data address
; @param de palette data destination address
; @return de = de + 64
; @preserves hl
save_palette:
    xor a
    ld (hl), a
    ld b, 64
save_palette_loop:
    ldh a, (c)
    ld (de), a
    inc de
    inc (hl)    ; move to next palette entry
    dec b
    jr nz, save_palette_loop
    ret