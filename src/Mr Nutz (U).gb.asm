; md5 7db13139bc32e2aadb732d610f4c1604

.INCLUDE "includes/init.asm"
.ROMBANKS 16
.BACKGROUND "Mr Nutz (U).gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $d8dc
.DEFINE joypad_2 $d8dd
.DEFINE joypad_debounce 1
.DEFINE current_rom_bank $7fff
.DEFINE preserve_register_a 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $80
.SECTION "joypad read" SIZE $80 OVERWRITE   
    .INCLUDE "includes/call_relocated_read_from_joypad_in_other_bank.s"  
    jp $12a6
.ENDS
.ORG $1296
.SECTION "joypad read call" SIZE 3 OVERWRITE   
    jp $0080
.ENDS


;*******************
;* save/load state *
;*******************

.BANK $01 SLOT 1
.ORG $3da0
.SECTION "save/load state" SIZE $260 OVERWRITE
    .DB "--- Mr Nutz Save Patch ---"
    .INCLUDE "includes/relocated_read_from_joypad.asm"
    .INCLUDE "includes/save_state_includes.asm"
.ENDS


;*******************
;* bank numbers... *
;*******************

.BANK $01 SLOT 1
.ORG $3fff
.SECTION "bank 1" SIZE 1 OVERWRITE
    .DB $1
.ENDS

.BANK $02 SLOT 1
.ORG $3fff
.SECTION "bank 2" SIZE 1 OVERWRITE
    .DB $2
.ENDS

.BANK $03 SLOT 1
.ORG $3fff
.SECTION "bank 3" SIZE 1 OVERWRITE
    .DB $3
.ENDS

.BANK $04 SLOT 1
.ORG $3fff
.SECTION "bank 4" SIZE 1 OVERWRITE
    .DB $4
.ENDS

.BANK $05 SLOT 1
.ORG $3fff
.SECTION "bank 5" SIZE 1 OVERWRITE
    .DB $5
.ENDS

.BANK $06 SLOT 1
.ORG $3fff
.SECTION "bank 6" SIZE 1 OVERWRITE
    .DB $6
.ENDS

.BANK $07 SLOT 1
.ORG $3fff
.SECTION "bank 7" SIZE 1 OVERWRITE
    .DB $7
.ENDS

.BANK $08 SLOT 1
.ORG $3fff
.SECTION "bank 8" SIZE 1 OVERWRITE
    .DB $8
.ENDS

.BANK $09 SLOT 1
.ORG $3fff
.SECTION "bank 9" SIZE 1 OVERWRITE
    .DB $9
.ENDS

.BANK $0a SLOT 1
.ORG $3fff
.SECTION "bank a" SIZE 1 OVERWRITE
    .DB $a
.ENDS

.BANK $0b SLOT 1
.ORG $3fff
.SECTION "bank b" SIZE 1 OVERWRITE
    .DB $b
.ENDS

.BANK $0c SLOT 1
.ORG $3fff
.SECTION "bank c" SIZE 1 OVERWRITE
    .DB $c
.ENDS

.BANK $0d SLOT 1
.ORG $3fff
.SECTION "bank d" SIZE 1 OVERWRITE
    .DB $d
.ENDS

.BANK $0e SLOT 1
.ORG $3fff
.SECTION "bank e" SIZE 1 OVERWRITE
    .DB $e
.ENDS

.BANK $0f SLOT 1
.ORG $3fff
.SECTION "bank f" SIZE 1 OVERWRITE
    .DB $f
.ENDS
