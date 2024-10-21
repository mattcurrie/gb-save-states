; md5 d9d957771484ef846d4e8d241f6f2815

.INCLUDE "includes/init.asm"
.ROMBANKS 32
.BACKGROUND "Wario Land - Super Mario Land 3 (W) [!].gb"
.INCLUDE "includes/header.asm"


;**********
;* config *
;**********

.DEFINE joypad $ff00+$80
.DEFINE joypad_2 $ff00+$81
.DEFINE current_rom_bank $a8c5
.DEFINE current_nr34_value $a64e
.DEFINE game_uses_save_ram 1


;***************
;* joypad read *
;***************

.BANK $00 SLOT 0
.ORG $11f0
.SECTION "joypad read" SIZE $2f OVERWRITE   
    ld a,(current_rom_bank)
    push af
    ld a,:relocated_read_from_joypad
    ld (current_rom_bank),a
    ld ($2100),a
    call relocated_read_from_joypad
    pop af              
    ld (current_rom_bank),a
    ld ($2100),a
    jr resume

invoke_joypad_check:
    ld a,(current_rom_bank)
    push af
    ld a,:joypad_check
    ld (current_rom_bank),a
    ld ($2100),a
    call joypad_check
    pop af              
    ld (current_rom_bank),a
    ld ($2100),a
    ret
resume:
.ENDS

.ORG $124d
.SECTION "do joypad check" SIZE 3 OVERWRITE   
    jp invoke_joypad_check
.ENDS




;*******************
;* save/load state *
;*******************

.BANK $11 SLOT 1
.ORG $3a00
.SECTION "save/load state" SIZE $600 OVERWRITE
    .DB "--- Wario Land Save Patch ---"

relocated_read_from_joypad:
    .INCLUDE "includes/joypad_read.asm"
    ret

    .INCLUDE "includes/joypad_check.asm"
    ret

    .INCLUDE "includes/save_state_includes.asm"
.ENDS
