; md5 849c5fe4002dd4240020e9ec84c8dc29

; ROMBANKS 8
; ROM "Darkman (U).gb"


;**********
;* config *
;**********

DEF current_rom_bank EQU $ffc0


;**********
;* vblank *
;**********

DEF vblank_handler EQU $0001
DEF original_vblank_handler EQU $3dfe
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7532], BANK[$0003] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
