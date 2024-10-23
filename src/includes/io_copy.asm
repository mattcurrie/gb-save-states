;***************************************************************************
;
; Copies 255 bytes or less into OAM/hi-ram/io area
;
; INPUT:
; HL = source address
; D = destination address high byte
; C = number of bytes to copy
;
; Function length: 8 bytes
;
;***************************************************************************

IO_COPY:
    ld e, l
io_copy_loop:
    ld a, [hl+]
    ld [de], a
    inc e                       
    dec c
    jr nz, io_copy_loop
    ret
