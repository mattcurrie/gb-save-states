;***************************************************************************
;
; Compress some data using PackBits compression 
; See: https://en.wikipedia.org/wiki/PackBits
;
; INPUT:
; HL = input address
; DE = output address
; BC = input length
;
; OUTPUT:
; HL = length of encoded output
;
; You must define two DW labels for working memory:
;     PACKBITS_INPUT_END_ADDRESS
;     PACKBITS_CURRENT_OUTPUT_ADDRESS
;
; Function length: 194 bytes
;
;***************************************************************************

PACKBITS_ENCODE:

    ; save the original output address for later
    push de

    ; store output address in PACKBITS_CURRENT_OUTPUT_ADDRESS
    ld a,e
    ld (PACKBITS_CURRENT_OUTPUT_ADDRESS),a
    ld a,d
    ld (PACKBITS_CURRENT_OUTPUT_ADDRESS + 1),a
    
    ; calculate the end of the input address and store 
    ; in DE and PACKBITS_INPUT_END_ADDRESS
    ld a,c
    add l
    ld e,a
    ld (PACKBITS_INPUT_END_ADDRESS),a

    ld a,b
    adc h
    ld d,a
    ld (PACKBITS_INPUT_END_ADDRESS + 1),a


    ; initialisation
    ld a,(hl)
    ld b,a  ; initialise previous byte with first byte
    ld c,0  ; counter


    ; in the main loop:
    ; HL = current address to read source data from
    ; DE = end address of the source data
    ; B = the value of the previous source data byte 
    ; C = counter - the number of times the byte B has appeared

PACKBITS_ENCODE_MAIN_LOOP:

    ; see we have reached the end of the source data
    ld a,d
    cp h
    jr nz,PACKBITS_ENCODE_CONTINUE

    ld a,e
    cp l
    jr nz,PACKBITS_ENCODE_CONTINUE

    ; de == hl so we are all done 
    jp PACKBITS_ENCODE_END


PACKBITS_ENCODE_CONTINUE:

    ; check if byte at HL equals the previous character. 
    ; if not, then we need to write some output
    ld a,(hl)
    cp b    
    jr nz,PACKBITS_ENCODE_OUTPUT


    ; check if the counter is 128 yet. 
    ; if so, then we need to write some output
    ld a,128
    cp c
    jr z,PACKBITS_ENCODE_OUTPUT 


    ; otherwise just increase the counter and move on to read the next byte
    jr PACKBITS_ENCODE_INCREASE_COUNTER




PACKBITS_ENCODE_OUTPUT:

    ; check the counter to see how many repeated bytes we have read
    ; if counter is only 1 then write some uncompressed output, otherwise 
    ; we can write some compressed output
    ld a,1
    cp c
    jr z,PACKBITS_ENCODE_UNCOMPRESSED_OUTPUT  




PACKBITS_ENCODE_COMPRESSED_OUTPUT:

    ; save current source data address from HL to stack
    push hl  


    ; load the current output address into HL
    ld hl,PACKBITS_CURRENT_OUTPUT_ADDRESS
    ld a,(hl+)
    ld h,(hl)
    ld l,a


    ; subtract 1 from the counter first then load into A
    dec c   
    ld a,c

    ; calculate the twos complement of the counter
    cpl
    inc a


    ; write the counter value
    ld (hl+),a   

    ; write the repeated byte value
    ld a,b
    ld (hl+),a 


    ; update the current output address
    ld a,l
    ld (PACKBITS_CURRENT_OUTPUT_ADDRESS),a
    ld a,h
    ld (PACKBITS_CURRENT_OUTPUT_ADDRESS + 1),a


    ; restore the source data read address into HL
    pop hl    

    jr PACKBITS_ENCODE_RESET_COUNTER




.INCLUDE "includes/packbits_generate_literal.asm"


PACKBITS_ENCODE_RESET_COUNTER:
    ld a,(hl)
    ld b,a

    ld c,0


PACKBITS_ENCODE_INCREASE_COUNTER:
    inc c   ; increase the counter
    inc hl  ; advance to next character in source data

    jp PACKBITS_ENCODE_MAIN_LOOP



PACKBITS_ENCODE_END:


    ; read the current output address into HL
    ld hl,PACKBITS_CURRENT_OUTPUT_ADDRESS
    ld a,(hl+)
    ld h,(hl)
    ld l,a


    ; if byte counter < 1
    ld a,c
    cp 1
    jr c,PACKBITS_ENCODE_SKIP_FINAL_RUN


    ; subtract 1 from counter because we want to store counter - 1
    dec c
    ld a,c

    ; calculate the twos complement of the counter
    cpl
    inc a        

    ld (hl+),a   ; write the counter

    ld a,b
    ld (hl+),a   ; write the byte


PACKBITS_ENCODE_SKIP_FINAL_RUN:

    ; expects that HL contains the address of last byte written + 1

    pop de   ; pop the original output address so we can calculate the number of bytes written

    ld a,l                      
    sub e                     
    ld l,a                    

    ld a,h                      
    sbc d                     
    ld h,a                    


    ret   ; returns with HL = number of bytes written


PACKBITS_ENCODE_END_OF_FUNCTION: