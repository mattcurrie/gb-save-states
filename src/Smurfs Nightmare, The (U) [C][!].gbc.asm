; md5 20052c527795a4f332be14aff49d4d4b

.INCLUDE "includes/init.asm"
.ROMBANKS 64
.BACKGROUND "Smurfs Nightmare, The (U) [C][!].gbc"
.INCLUDE "includes/header.asm"


; config
.DEFINE is_cgb 1
.DEFINE current_rom_bank $7fff
.DEFINE uses_mbc5 1


; joypad
.DEFINE joypad $fff5
.DEFINE joypad_2 $fff6

.BANK $0000 SLOT 0
.ORG $3f00
.SECTION "relocated read from joypad" SIZE $40 OVERWRITE
    .DEFINE interrupts_already_disabled 1
    .INCLUDE "includes/relocated_read_from_joypad.asm"
.ENDS

.BANK 7
.ORG $3fe7
.SECTION "joypad read" SIZE 14 OVERWRITE
    ldh a, [$f5]
    xor b
    and b
    ldh [$f6], a
    ld a, b
    ldh [$f5], a
    call relocated_read_from_joypad
    ret
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $0010 SLOT 1
.ORG $0001
.SECTION "save/load state" SIZE $02e0 OVERWRITE
    .DB "--- Save Patch ---"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS

.BANK $01 SLOT 1
.ORG $3fff
.SECTION "bank-number-01" SIZE 1 OVERWRITE
    .DB $01
.ENDS

.BANK $02 SLOT 1
.ORG $3fff
.SECTION "bank-number-02" SIZE 1 OVERWRITE
    .DB $02
.ENDS

.BANK $03 SLOT 1
.ORG $3fff
.SECTION "bank-number-03" SIZE 1 OVERWRITE
    .DB $03
.ENDS

.BANK $04 SLOT 1
.ORG $3fff
.SECTION "bank-number-04" SIZE 1 OVERWRITE
    .DB $04
.ENDS

.BANK $05 SLOT 1
.ORG $3fff
.SECTION "bank-number-05" SIZE 1 OVERWRITE
    .DB $05
.ENDS

.BANK $06 SLOT 1
.ORG $3fff
.SECTION "bank-number-06" SIZE 1 OVERWRITE
    .DB $06
.ENDS

.BANK $07 SLOT 1
.ORG $3fff
.SECTION "bank-number-07" SIZE 1 OVERWRITE
    .DB $07
.ENDS

.BANK $08 SLOT 1
.ORG $3fff
.SECTION "bank-number-08" SIZE 1 OVERWRITE
    .DB $08
.ENDS

.BANK $09 SLOT 1
.ORG $3fff
.SECTION "bank-number-09" SIZE 1 OVERWRITE
    .DB $09
.ENDS

.BANK $0a SLOT 1
.ORG $3fff
.SECTION "bank-number-0a" SIZE 1 OVERWRITE
    .DB $0a
.ENDS

.BANK $0b SLOT 1
.ORG $3fff
.SECTION "bank-number-0b" SIZE 1 OVERWRITE
    .DB $0b
.ENDS

.BANK $0c SLOT 1
.ORG $3fff
.SECTION "bank-number-0c" SIZE 1 OVERWRITE
    .DB $0c
.ENDS

.BANK $0d SLOT 1
.ORG $3fff
.SECTION "bank-number-0d" SIZE 1 OVERWRITE
    .DB $0d
.ENDS

.BANK $0e SLOT 1
.ORG $3fff
.SECTION "bank-number-0e" SIZE 1 OVERWRITE
    .DB $0e
.ENDS

.BANK $0f SLOT 1
.ORG $3fff
.SECTION "bank-number-0f" SIZE 1 OVERWRITE
    .DB $0f
.ENDS

.BANK $10 SLOT 1
.ORG $3fff
.SECTION "bank-number-10" SIZE 1 OVERWRITE
    .DB $10
.ENDS

.BANK $11 SLOT 1
.ORG $3fff
.SECTION "bank-number-11" SIZE 1 OVERWRITE
    .DB $11
.ENDS

.BANK $12 SLOT 1
.ORG $3fff
.SECTION "bank-number-12" SIZE 1 OVERWRITE
    .DB $12
.ENDS

.BANK $13 SLOT 1
.ORG $3fff
.SECTION "bank-number-13" SIZE 1 OVERWRITE
    .DB $13
.ENDS

.BANK $14 SLOT 1
.ORG $3fff
.SECTION "bank-number-14" SIZE 1 OVERWRITE
    .DB $14
.ENDS

.BANK $15 SLOT 1
.ORG $3fff
.SECTION "bank-number-15" SIZE 1 OVERWRITE
    .DB $15
.ENDS

.BANK $16 SLOT 1
.ORG $3fff
.SECTION "bank-number-16" SIZE 1 OVERWRITE
    .DB $16
.ENDS

.BANK $17 SLOT 1
.ORG $3fff
.SECTION "bank-number-17" SIZE 1 OVERWRITE
    .DB $17
.ENDS

.BANK $18 SLOT 1
.ORG $3fff
.SECTION "bank-number-18" SIZE 1 OVERWRITE
    .DB $18
.ENDS

.BANK $19 SLOT 1
.ORG $3fff
.SECTION "bank-number-19" SIZE 1 OVERWRITE
    .DB $19
.ENDS

.BANK $1a SLOT 1
.ORG $3fff
.SECTION "bank-number-1a" SIZE 1 OVERWRITE
    .DB $1a
.ENDS

.BANK $1b SLOT 1
.ORG $3fff
.SECTION "bank-number-1b" SIZE 1 OVERWRITE
    .DB $1b
.ENDS

.BANK $1c SLOT 1
.ORG $3fff
.SECTION "bank-number-1c" SIZE 1 OVERWRITE
    .DB $1c
.ENDS

.BANK $1d SLOT 1
.ORG $3fff
.SECTION "bank-number-1d" SIZE 1 OVERWRITE
    .DB $1d
.ENDS

.BANK $1e SLOT 1
.ORG $3fff
.SECTION "bank-number-1e" SIZE 1 OVERWRITE
    .DB $1e
.ENDS

.BANK $1f SLOT 1
.ORG $3fff
.SECTION "bank-number-1f" SIZE 1 OVERWRITE
    .DB $1f
.ENDS

.BANK $20 SLOT 1
.ORG $3fff
.SECTION "bank-number-20" SIZE 1 OVERWRITE
    .DB $20
.ENDS

.BANK $21 SLOT 1
.ORG $3fff
.SECTION "bank-number-21" SIZE 1 OVERWRITE
    .DB $21
.ENDS

.BANK $22 SLOT 1
.ORG $3fff
.SECTION "bank-number-22" SIZE 1 OVERWRITE
    .DB $22
.ENDS

.BANK $23 SLOT 1
.ORG $3fff
.SECTION "bank-number-23" SIZE 1 OVERWRITE
    .DB $23
.ENDS

.BANK $24 SLOT 1
.ORG $3fff
.SECTION "bank-number-24" SIZE 1 OVERWRITE
    .DB $24
.ENDS

.BANK $25 SLOT 1
.ORG $3fff
.SECTION "bank-number-25" SIZE 1 OVERWRITE
    .DB $25
.ENDS

.BANK $26 SLOT 1
.ORG $3fff
.SECTION "bank-number-26" SIZE 1 OVERWRITE
    .DB $26
.ENDS

.BANK $27 SLOT 1
.ORG $3fff
.SECTION "bank-number-27" SIZE 1 OVERWRITE
    .DB $27
.ENDS

.BANK $28 SLOT 1
.ORG $3fff
.SECTION "bank-number-28" SIZE 1 OVERWRITE
    .DB $28
.ENDS

.BANK $29 SLOT 1
.ORG $3fff
.SECTION "bank-number-29" SIZE 1 OVERWRITE
    .DB $29
.ENDS

.BANK $2a SLOT 1
.ORG $3fff
.SECTION "bank-number-2a" SIZE 1 OVERWRITE
    .DB $2a
.ENDS

.BANK $2b SLOT 1
.ORG $3fff
.SECTION "bank-number-2b" SIZE 1 OVERWRITE
    .DB $2b
.ENDS

.BANK $2c SLOT 1
.ORG $3fff
.SECTION "bank-number-2c" SIZE 1 OVERWRITE
    .DB $2c
.ENDS

.BANK $2d SLOT 1
.ORG $3fff
.SECTION "bank-number-2d" SIZE 1 OVERWRITE
    .DB $2d
.ENDS

.BANK $2e SLOT 1
.ORG $3fff
.SECTION "bank-number-2e" SIZE 1 OVERWRITE
    .DB $2e
.ENDS

.BANK $2f SLOT 1
.ORG $3fff
.SECTION "bank-number-2f" SIZE 1 OVERWRITE
    .DB $2f
.ENDS

.BANK $30 SLOT 1
.ORG $3fff
.SECTION "bank-number-30" SIZE 1 OVERWRITE
    .DB $30
.ENDS

.BANK $31 SLOT 1
.ORG $3fff
.SECTION "bank-number-31" SIZE 1 OVERWRITE
    .DB $31
.ENDS

.BANK $32 SLOT 1
.ORG $3fff
.SECTION "bank-number-32" SIZE 1 OVERWRITE
    .DB $32
.ENDS

.BANK $33 SLOT 1
.ORG $3fff
.SECTION "bank-number-33" SIZE 1 OVERWRITE
    .DB $33
.ENDS

.BANK $34 SLOT 1
.ORG $3fff
.SECTION "bank-number-34" SIZE 1 OVERWRITE
    .DB $34
.ENDS

.BANK $35 SLOT 1
.ORG $3fff
.SECTION "bank-number-35" SIZE 1 OVERWRITE
    .DB $35
.ENDS

.BANK $36 SLOT 1
.ORG $3fff
.SECTION "bank-number-36" SIZE 1 OVERWRITE
    .DB $36
.ENDS

.BANK $37 SLOT 1
.ORG $3fff
.SECTION "bank-number-37" SIZE 1 OVERWRITE
    .DB $37
.ENDS

.BANK $38 SLOT 1
.ORG $3fff
.SECTION "bank-number-38" SIZE 1 OVERWRITE
    .DB $38
.ENDS

.BANK $39 SLOT 1
.ORG $3fff
.SECTION "bank-number-39" SIZE 1 OVERWRITE
    .DB $39
.ENDS

.BANK $3a SLOT 1
.ORG $3fff
.SECTION "bank-number-3a" SIZE 1 OVERWRITE
    .DB $3a
.ENDS

.BANK $3b SLOT 1
.ORG $3fff
.SECTION "bank-number-3b" SIZE 1 OVERWRITE
    .DB $3b
.ENDS

.BANK $3c SLOT 1
.ORG $3fff
.SECTION "bank-number-3c" SIZE 1 OVERWRITE
    .DB $3c
.ENDS

.BANK $3d SLOT 1
.ORG $3fff
.SECTION "bank-number-3d" SIZE 1 OVERWRITE
    .DB $3d
.ENDS

.BANK $3e SLOT 1
.ORG $3fff
.SECTION "bank-number-3e" SIZE 1 OVERWRITE
    .DB $3e
.ENDS

.BANK $3f SLOT 1
.ORG $3fff
.SECTION "bank-number-3f" SIZE 1 OVERWRITE
    .DB $3f
.ENDS


; Generated with patch-builder.py
