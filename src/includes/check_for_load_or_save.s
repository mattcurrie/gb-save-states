;***************************************************************************;
;
; Checks if load/save key combinations are pressed on  the joypad and
; invokes save/load game
;
; Function length: 69 bytes
;
;***************************************************************************

CHECK_FOR_SAVE_OR_LOAD_GAME:
    
    ld a,c    ; c has the joypad data

    bit 3,a
    jr nz,START_HELD

    bit 2,a
    jr z,NO_ACTION

SELECT_HELD:

    ; check for a
    bit 0,a
    jr nz, WILL_SAVE

    ; check for b
    bit 1,a
    jr nz, WILL_LOAD
    
NO_ACTION:
    xor a
    ret    


START_HELD:

    ; check for down
    bit 7,a
    jr nz, WILL_SAVE

    ; check for up, if so, then fall through to WILL_LOAD
    bit 6,a
    jr z, NO_ACTION



WILL_LOAD:
    ld c,1
    jr PREPARE_FOR_SAVE_OR_LOAD

WILL_SAVE:
    ld c,0


PREPARE_FOR_SAVE_OR_LOAD:

    ; prepare for save or load


    ld a,1                      ; set MBC1 mode to 4/32KB
    ld ($6000),a


    ld a,$0a  ; enable access to ram bank
    ld (ram_access_toggle),a

.IFDEF is_cgb
    ; wait for any in progress G/HDMA
    ; $ff in $ff55 indicates G/HDMA is complete
dma_wait_loop:
    ldh a, ($55)
    inc a
    jr nz, dma_wait_loop
.ENDIF


SCREEN_OFF:
    ld hl,$ff40
SCREEN_OFF_LOOP:
    ld a,($ff00+$44)
    cp $90
    jr nz, SCREEN_OFF_LOOP
    res 7,(hl)


    ld a,(SAVE_STATE_RAM_BANK)
    ld (ram_bank_select),a


    ld a,c
    and 1            ; 1 = loading
    jp nz,LOAD_GAME

    jp SAVE_GAME

    