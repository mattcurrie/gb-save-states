;***************************************************************************
;
; Save or load a game state
;
;***************************************************************************

IF DEF(current_nr34_value)
    DEF restore_wave_ram EQU 1
ENDC

SAVE_GAME:
   
    ; save the stack pointer
    ld [stack_pointer_save],sp

    ; set stack pointer to top of save ram
    ld sp,working_stack_pointer_address


IF DEF(game_uses_save_ram)

    ld d,0    
    ld a,[SAVE_STATE_SRAM_BANK_0]
    ld e,a
    call COPY_BETWEEN_SRAM_BANKS

IF DEF(current_sram_bank)
    ld de, (1 << 8) | save_state_sram_bank_1
    call COPY_BETWEEN_SRAM_BANKS
    ld de, (2 << 8) | save_state_sram_bank_2
    call COPY_BETWEEN_SRAM_BANKS
    ld de, (3 << 8) | save_state_sram_bank_3
    call COPY_BETWEEN_SRAM_BANKS
ENDC

ENDC

IF DEF(restore_wave_ram)
    ; disable sound 3 using NR30 register before reading sound wave ram
    xor a
    ldh [$FF00+$1A],a
ENDC

    ; copy high-ram, registers, etc
    ld hl, $FF00    ; source
    ld d, HIGH(io_save)  ; dest
    ld c, 0         ; (256)
    call IO_COPY

    ; copy OAM 
    ld hl, $fe00     ; source
    ld d, HIGH(oam_save)  ; dest
    ld c, $a0        ; length
    call IO_COPY

    ; set magic byte
    ld a,magic_byte_value   
    ld [magic_byte_save],a

IF DEF(is_cgb)

INCLUDE "includes/save_cgb.asm"

ELSE
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
    ld a,[SAVE_STATE_RAM_BANK_VRAM]
    ld [ram_bank_select],a

    ld hl,$8000 ; source

    jr RAM_COPY
ENDC

;***************************************************************************

LOAD_GAME:


    ld a,[magic_byte_save]   ; check for magic byte
    cp magic_byte_value
    jp nz,ABORT_LOAD


    ; set stack pointer to top of save ram
    ld sp,working_stack_pointer_address


IF DEF(game_uses_save_ram)
    ld a,[SAVE_STATE_SRAM_BANK_0]
    ld d,a
    ld e,0
    call COPY_BETWEEN_SRAM_BANKS
IF DEF(current_sram_bank)
    ld de, (save_state_sram_bank_1 << 8) | 1
    call COPY_BETWEEN_SRAM_BANKS
    ld de, (save_state_sram_bank_2 << 8) | 2
    call COPY_BETWEEN_SRAM_BANKS
    ld de, (save_state_sram_bank_3 << 8) | 3
    call COPY_BETWEEN_SRAM_BANKS
ENDC
ENDC

    ; restore OAM
    ld hl, oam_save ; source
    ld d, $fe       ; high(dest)
    ld c, $a0       ; length
    call IO_COPY

    ; restore low registers
    ld hl, io_save + 1; source
    ld d, $ff       ; high(dest)
    ld c, $0f       ; length
    call IO_COPY

IF DEF(restore_wave_ram)
    ; disable sound 3 before writing wave ram
    xor a
    ldh [$FF00+$1A],a

    ; copy wave ram
    ld hl, io_save + $30 ; source
    ld d, $ff   ; high(dest)
    ld c, $10   ; length
    call IO_COPY
ENDC

    ; copy ppu regs $ff40 - $ff45
    ld hl, io_save + $40 ; source
    ld d, $ff   ; high(dest)
    ld c, $6 ; length
    call IO_COPY

IF DEF(is_cgb)
    ; copy more ppu regs and cgb $ff47 - $ff54
    inc hl
    ld c, $ff54 - $ff47 + 1 ; length
    call IO_COPY

    ; copy from $ff56 - $ffff
    inc hl    
    ld c, $ffff - $ff56 + 1 ; length
    call IO_COPY

ELSE

    ; copy more ppu regs and high ram $ff47 - $ffff
    inc hl
    ld c, $ffff - $ff47 + 1 ; length
    call IO_COPY

ENDC


IF DEF(restore_sound)
    call RESTORE_SOUND
ENDC



IF DEF(is_cgb)

INCLUDE "includes/load_cgb.asm"

ELSE

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

    ld a,[SAVE_STATE_RAM_BANK_VRAM]
    ld [ram_bank_select],a


    ld de,$8000 ; dest
ENDC

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
    ld a,[hl+]                   
    ld [de],a                   
    inc de                      

    dec bc
    
    ld a,b
    or c

    jr nz,RAM_COPY



RAM_COPY_DONE:

    ; select ram bank (and restore the stack pointer)
    ld a,[SAVE_STATE_RAM_BANK]
    ld [ram_bank_select],a

IF DEF(restore_wave_ram)
    call RESTORE_NR_34
ENDC

    ; load the stack pointer
    ld a,[stack_pointer_save]
    ld l,a

    ld a,[stack_pointer_save + 1]
    ld h,a

    ld sp,hl



ABORT_LOAD:

    ; turn the screen on

    ld hl,$ff40
    set 7,[hl]

    ; wait for vblank - tries to prevent the game from writing to vram when inaccessible
wait_vbl:
    ldh a,[$ff00+$44]
    cp $90
    jr nz,wait_vbl


IF DEF(game_uses_save_ram)
    ; restore sram bank
    IF DEF(current_sram_bank)
        ld a, [current_sram_bank]
    ELSE
        xor a
    ENDC
    ld [ram_bank_select],a
ELSE
    ; lock access to ram bank
    xor a  
    ld [ram_access_toggle],a
ENDC

    inc a   ; A = 1, loaded/saved a game


    ret


IF DEF(restore_sound)

;***************************************************************************
;
; Restore the sound registers that can be read. 
; Some sound registers are write-only so do not try to restore those.
;
;***************************************************************************

RESTORE_SOUND:

    ; restore NR 52
    ld a,[io_save + $26]
    bit 7,a
    jr nz,RESTORE_SOUND_CONTINUE

    ; disable sound
    xor a
    ldh [$ff00 + $26],a
    ret

RESTORE_SOUND_CONTINUE:

    ldh [$ff00 + $26],a

    ; restore NR 10
    ld a,[io_save + $10]
    ldh [$ff00 + $10],a

    ; restore NR 11, bits 6 and 7
    ld a,[io_save + $10]
    and $c0
    ldh [$ff00 + $10],a

    ; restore NR 13
    ld a,[io_save + $12]
    ldh [$ff00 + $12],a

    ; restore NR 14, bit 6
    ld a,[io_save + $14]
    and $40
    ldh [$ff00 + $14],a

    ; restore NR 21, bits 6 and 7
    ld a,[io_save + $16]
    and $c0
    ldh [$ff00 + $16],a

    ; restore NR 22
    ld a,[io_save + $17]
    ldh [$ff00 + $17],a

    ; restore NR 24, bit 6
    ld a,[io_save + $19]
    and $40
    ldh [$ff00 + $19],a

    ; restore NR 30
    ld a,[io_save + $1A]
    ldh [$ff00 + $1A],a

    ; restore NR 31
    ld a,[io_save + $1B]
    ldh [$ff00 + $1B],a

    ; restore NR 32
    ld a,[io_save + $1C]
    ldh [$ff00 + $1C],a

    ; restore NR 34, bit 6
    ld a,[io_save + $1E]
    and $40
    ldh [$ff00 + $1E],a

    ; restore NR 41
    ld a,[io_save + $20]
    ldh [$ff00 + $20],a

    ; restore NR 42
    ld a,[io_save + $21]
    ldh [$ff00 + $21],a

    ; restore NR 43
    ld a,[io_save + $22]
    ldh [$ff00 + $22],a

    ; restore NR 44, bit 6
    ld a,[io_save + $23]
    and $40
    ldh [$ff00 + $23],a

    ; restore NR 50
    ld a,[io_save + $24]
    ldh [$ff00 + $24],a

    ; restore NR 51
    ld a,[io_save + $25]
    ldh [$ff00 + $25],a

    ret

ENDC


IF DEF(restore_wave_ram)

RESTORE_NR_34:

    ld a,[io_save + $1A]
    bit 7,a
    ret z

    ; restore value of NR30 sound register
    ld a,[io_save + $1A]
    ldh [$FF00+$1A],a

IF DEF(current_nr34_value)

    ; check bit 6 of NR 34
    ;     0 = Regardless of the length data in NR31
    ;    sound can be produced consecutively.
    ;    if reset then enable sound 3

    ld a,[io_save + $1E]
    bit 6,a 
    ret nz

    ; set bit 7 on NR 34 to start the sound again
    ld a,[current_nr34_value]
    set 7,a
    ldh [$ff1e],a 

ENDC

    ret
ENDC



IF DEF(game_uses_save_ram)

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
    ld [ram_bank_select],a

    ld b,[hl]   
    inc hl
    ld c,[hl]
    dec hl

    ld a,e
    ld [ram_bank_select],a

    ld [hl],b
    inc hl
    ld [hl],c
    inc hl

    ; bit 6 of HL will be set when HL equals $c000
    bit 6,h
    jr z,COPY_BETWEEN_SRAM_BANKS_LOOP

    ; need to switch back the ram bank that has the stack on it before returning
    ld a,[SAVE_STATE_RAM_BANK]
    ld [ram_bank_select],a


    ret


ENDC
