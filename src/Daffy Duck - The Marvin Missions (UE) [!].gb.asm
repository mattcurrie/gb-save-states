; md5 f1dbc21b1b8f8dcbe9a15bc9ef68fb9c

; ROMBANKS 8
; ROM "Daffy Duck - The Marvin Missions (UE) [!].gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ffa0


;**********
;* vblank *
;**********

DEF vblank_handler EQU $0079
DEF original_vblank_handler EQU $0719
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7CC8], BANK[$0006] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
