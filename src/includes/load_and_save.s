;***************************************************************************
;
; Save or load a game state
;
;***************************************************************************

.IFDEF current_nr34_value
    .DEFINE restore_wave_ram 1
.ENDIF

SAVE_GAME:
   
    ; save the stack pointer
    ld (stack_pointer_save),sp

    ; set stack pointer to top of save ram
    ld sp,working_stack_pointer_address


.IFDEF game_uses_save_ram

    ; source is always bank 0
    ld d,0
    
    ld a,(SAVE_STATE_RAM_BANK_SRAM)
    ld e,a

    call COPY_BETWEEN_SRAM_BANKS

.ENDIF


    ; copy low registers and sound registers
    ld hl,$FF00     ; source
    ld de,io_save   ; dest
    ld bc,$4630     ; length and ignore address
    call IO_COPY

.IFDEF restore_wave_ram
    ; disable sound 3 using NR30 register before reading sound wave ram
    xor a
    ld ($FF00+$1A),a
.ENDIF

    ; copy hi-ram and high registers and wave ram
    ld hl,$FF30     ; source
    ld de,io_save + $30  ; dest
    ld bc,$46CF     ; length and ignore address
    call IO_COPY

    ; copy OAM 
    ld hl,$FE00     ; source
    ld de,oam_save  ; dest
    ld bc,$FFA0     ; length and ignore address
    call IO_COPY



    ; set magic byte
    ld a,magic_byte_value   
    ld (magic_byte_save),a


    ld hl,$C000 ; input
    ld de,$A000 ; output
    ld bc,$2000 ; input length

    push de
    push bc

    call PACKBITS_ENCODE

    ; pop values out to use them for the RAM_COPY function
    pop bc  ; $2000 length
    pop de  ; $A000 destination


    ; straight copy of the vram - switch to the correct ram bank
    ld a,(SAVE_STATE_RAM_BANK_VRAM)
    ld (ram_bank_select),a

    ld hl,$8000 ; source

    jr RAM_COPY


;***************************************************************************

LOAD_GAME:


    ld a,(magic_byte_save)   ; check for magic byte
    cp magic_byte_value
    jr nz,ABORT_LOAD


    ; set stack pointer to top of save ram
    ld sp,working_stack_pointer_address


.IFDEF game_uses_save_ram

    ld a,(SAVE_STATE_RAM_BANK_SRAM)
    ld d,a

    ; destination is always bank 0
    ld e,0
    
    call COPY_BETWEEN_SRAM_BANKS

.ENDIF


    ld hl,oam_save ; source
    ld de,$FE00 ; dest
    ld bc,$FFA0 ; length and ignore address
    call IO_COPY


.IFDEF restore_wave_ram
    ; disable sound 3 before writing wave ram
    xor a
    ld ($FF00+$1A),a

    ; copy hi-ram and high registers and wave ram
    ld hl,io_save + $30; source
    ld de,$FF30 ; dest  
    ld bc,$46CF ; length - $cf bytes
    call IO_COPY

.ELSE

    ; copy hi-ram and high registers
    ld hl,io_save + $40; source
    ld de,$FF40 ; dest  
    ld bc,$46BF ; length - $bf bytes
    call IO_COPY

.ENDIF



.IFDEF restore_sound
    call RESTORE_SOUND
.ENDIF

    ; copy low registers
    ld hl,io_save + 1; source
    ld de,$FF01 ; dest  
    ld bc,$460F ; length - $0f bytes
    call IO_COPY


    ; restore the WRAM

    ld hl,$A000 ; source
    ld de,$C000 ; dest
    ld bc,$2000 ; output length
    
    push hl
    push bc

    call PACKBITS_DECODE

    pop bc
    pop hl
    
    ; restore the VRAM

    ld a,(SAVE_STATE_RAM_BANK_VRAM)
    ld (ram_bank_select),a


    ld de,$8000 ; dest


    ; cannot call this because stack is not available when switching to this bank




;***************************************************************************
;
; Copy data (dont use for OAM or hi-ram area due to OAM CPU bug and DMA
; transfer)
;
; INPUT:
; HL = source address
; DE = destination address
; BC = number of bytes to copy
;
;***************************************************************************

RAM_COPY:
    ld a,(hl+)                   
    ld (de),a                   
    inc de                      

    dec bc
    
    ld a,b
    or c

    jr nz,RAM_COPY



RAM_COPY_DONE:

    ; select ram bank (and restore the stack pointer)
    ld a,(SAVE_STATE_RAM_BANK)
    ld (ram_bank_select),a

.IFDEF restore_wave_ram
    call RESTORE_NR_34
.ENDIF

    ; load the stack pointer
    ld a,(stack_pointer_save)
    ld l,a

    ld a,(stack_pointer_save + 1)
    ld h,a

    ld sp,hl



ABORT_LOAD:

    ; turn the screen on

    ld hl,$ff40
    set 7,(hl)

    ; wait for vblank - tries to prevent the game from writing to vram when inaccessible
wait_vbl:
    ld a,($ff00+$44)
    cp $90
    jr nz,wait_vbl


    xor a  

.IFDEF game_uses_save_ram
    ; restore bank 0
    ld (ram_bank_select),a
.ELSE
    ; lock access to ram bank
    ld (ram_access_toggle),a
.ENDIF

    inc a   ; A = 1, loaded/saved a game


    ret


.IFDEF restore_sound

;***************************************************************************
;
; Restore the sound registers that can be read. 
; Some sound registers are write-only so do not try to restore those.
;
;***************************************************************************

RESTORE_SOUND:

    ; restore NR 52
    ld a,(io_save + $26)
    bit 7,a
    jr nz,RESTORE_SOUND_CONTINUE

    ; disable sound
    xor a
    ld ($ff00 + $26),a
    ret

RESTORE_SOUND_CONTINUE:

    ld ($ff00 + $26),a

    ; restore NR 10
    ld a,(io_save + $10)
    ld ($ff00 + $10),a

    ; restore NR 11, bits 6 and 7
    ld a,(io_save + $10)
    and $c0
    ld ($ff00 + $10),a

    ; restore NR 13
    ld a,(io_save + $12)
    ld ($ff00 + $12),a

    ; restore NR 14, bit 6
    ld a,(io_save + $14)
    and $40
    ld ($ff00 + $14),a

    ; restore NR 21, bits 6 and 7
    ld a,(io_save + $16)
    and $c0
    ld ($ff00 + $16),a

    ; restore NR 22
    ld a,(io_save + $17)
    ld ($ff00 + $17),a

    ; restore NR 24, bit 6
    ld a,(io_save + $19)
    and $40
    ld ($ff00 + $19),a

    ; restore NR 30
    ld a,(io_save + $1A)
    ld ($ff00 + $1A),a

    ; restore NR 31
    ld a,(io_save + $1B)
    ld ($ff00 + $1B),a

    ; restore NR 32
    ld a,(io_save + $1C)
    ld ($ff00 + $1C),a

    ; restore NR 34, bit 6
    ld a,(io_save + $1E)
    and $40
    ld ($ff00 + $1E),a

    ; restore NR 41
    ld a,(io_save + $20)
    ld ($ff00 + $20),a

    ; restore NR 42
    ld a,(io_save + $21)
    ld ($ff00 + $21),a

    ; restore NR 43
    ld a,(io_save + $22)
    ld ($ff00 + $22),a

    ; restore NR 44, bit 6
    ld a,(io_save + $23)
    and $40
    ld ($ff00 + $23),a

    ; restore NR 50
    ld a,(io_save + $24)
    ld ($ff00 + $24),a

    ; restore NR 51
    ld a,(io_save + $25)
    ld ($ff00 + $25),a

    ret

.ENDIF


.IFDEF restore_wave_ram

RESTORE_NR_34:

    ld a,(io_save + $1A)
    bit 7,a
    ret z

    ; restore value of NR30 sound register
    ld a,(io_save + $1A)
    ld ($FF00+$1A),a

.IFDEF current_nr34_value

    ; check bit 6 of NR 34
    ;     0 = Regardless of the length data in NR31
    ;    sound can be produced consecutively.
    ;    if reset then enable sound 3

    ld a,(io_save + $1E)
    bit 6,a 
    ret nz

    ; set bit 7 on NR 34 to start the sound again
    ld a,(current_nr34_value)
    set 7,a
    ld ($ff1e),a 

.ENDIF

    ret
.ENDIF



.IFDEF game_uses_save_ram

;***************************************************************************
;
; Copy 8KB of data between two SRAM banks. 
; TODO: Use WRAM to speed up the copy process.
;
; INPUT:
; D = source ram bank
; E = destination ram bank
;
;***************************************************************************

COPY_BETWEEN_SRAM_BANKS:

    ld hl,$a000
    
COPY_BETWEEN_SRAM_BANKS_LOOP:

    ld a,d
    ld (ram_bank_select),a

    ld b,(hl)   
    inc hl
    ld c,(hl)
    dec hl

    ld a,e
    ld (ram_bank_select),a

    ld (hl),b
    inc hl
    ld (hl),c
    inc hl

    ; bit 6 of HL will be set when HL equals $c000
    bit 6,h
    jr z,COPY_BETWEEN_SRAM_BANKS_LOOP

    ; need to switch back the ram bank that has the stack on it before returning
    ld a,(SAVE_STATE_RAM_BANK)
    ld (ram_bank_select),a


    ret


.ENDIF