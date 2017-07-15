;***************************************************************************
;
; Copies 255 bytes or less into OAM/hi-ram/io area
; HL = source address
; DE = destination address
; C = number of bytes to copy
; B = dont copy the byte at address "HB"
;
;
; Function length: 12 bytes
;***************************************************************************

IO_COPY:
    ld a,e
    cp b                  ; if e == b then dont copy that byte. Used to avoid initiating a DMA transfer
    jr z,IO_COPY_SKIP

    ld a,(hl)                   
    ld (de),a                   
IO_COPY_SKIP:

    inc l                       
    inc e                       

    dec c
    jr nz,IO_COPY

    ret