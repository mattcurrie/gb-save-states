PACKBITS_ENCODE_UNCOMPRESSED_OUTPUT:

    push de    ; save the end of source data address

    ; load the current output address from $BFFE into DE
    ld a,(PACKBITS_CURRENT_OUTPUT_ADDRESS)
    ld e,a

    ld a,(PACKBITS_CURRENT_OUTPUT_ADDRESS + 1)
    ld d,a    

    push de   ; remember the original output address so can write the length to it later


    ld a,b  ; grab the previous byte and write it
    inc de
    ld (de),a
    inc de



PACKBITS_ENCODE_UNCOMPRESSED_LOOP:

    ; check if already at the end of the data

    push de     ; save the current output address

    ; load the end input address from $BFFC into DE
    ld a,(PACKBITS_INPUT_END_ADDRESS)   ; 16 clocks
    ld e,a         ; 4 clocks

    ld a,(PACKBITS_INPUT_END_ADDRESS + 1)   ; 16 clocks
    ld d,a         ; 4 clocks


    ld a,d
    cp h
    jr nz,PACKBITS_ENCODE_UNCOMPRESSED_CONTINUE

    ld a,e
    cp l
    jr nz,PACKBITS_ENCODE_UNCOMPRESSED_CONTINUE

        ; restore the current output address into HL to
        ; satisfy PACKBITS_ENCODE_SKIP_FINAL_RUN expectation
        pop hl    

        ; all done, so write the bytes then bail out completely

        ; write the current output address from DE into $BFFE
        ld a,l
        ld (PACKBITS_CURRENT_OUTPUT_ADDRESS),a

        ld a,h
        ld (PACKBITS_CURRENT_OUTPUT_ADDRESS + 1),a

        pop de   ; get the original output address so can write the length

        ld a,c
        dec a
        ld (de),a     ; write the length - 1 byte

        pop de    ; restore the end of source data address to DE

        jr PACKBITS_ENCODE_SKIP_FINAL_RUN



PACKBITS_ENCODE_UNCOMPRESSED_CONTINUE:

    pop de    ; restore the current output address 


    ld a, 128
    cp c
    jr z,PACKBITS_ENCODE_STOP_UNCOMPRESSED_OUTPUT    ; if 128 bytes long already then stop looping

 
    ld a,(hl)
    cp b
    jr z,PACKBITS_ENCODE_STOP_UNCOMPRESSED_OUTPUT_DUPE    ; if its the same byte then stop looping


    ; write the byte out then
    ld (de),a   ; write the uncompressed data
    inc de

    ld b,a     ; update the previous byte to the new value

    ; all good, so increase HL and byte counter
    inc hl    
    inc c

    jr PACKBITS_ENCODE_UNCOMPRESSED_LOOP


PACKBITS_ENCODE_STOP_UNCOMPRESSED_OUTPUT_DUPE:

    dec de    ; subtract 1 from de because the last byte written was the start of a duplicate
    dec c     ; subtract 1 from c because the last byte written was the start of a duplicate
    dec hl    ; subtract 1 from hl because the last byte written was the start of a duplicate


PACKBITS_ENCODE_STOP_UNCOMPRESSED_OUTPUT:

    ; write to the current output address from DE
    ld a,e
    ld (PACKBITS_CURRENT_OUTPUT_ADDRESS),a

    ld a,d
    ld (PACKBITS_CURRENT_OUTPUT_ADDRESS + 1),a

    pop de   ; get the original output address so can write the length

    ld a,c
    dec a
    ld (de),a     ; write the length byte



    pop de    ; restore the end of source address to DE

    

