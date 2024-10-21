; md5 f9e94b9a134d900a3b971e206f4e826c

; ROMBANKS 32
; ROM "Dragon Heart (U) [!].gb"


;**********
;* vblank *
;**********

DEF vblank_handler EQU $00dc
DEF original_vblank_handler EQU $20ef
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROM0[$3cd7] ; length: $02a0
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
