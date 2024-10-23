; md5 028c4262dbb49f4fc462a6eb3e514d72

; ROMBANKS 256
; ROM "Shantae (U) [C][!].gbc"


;**********
;* config *
;**********

DEF is_cgb EQU 1
DEF current_rom_bank EQU $ff91
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


;**********
;* vblank *
;**********

DEF vblank_handler EQU $0004
DEF original_vblank_handler EQU $0884
INCLUDE "includes/vblank_handler.asm"


;*******************
;* save/load state *
;*******************

SECTION "save/load state", ROMX[$7841], BANK[$0002] ; length: $0305
    DB "--- Save Patch ---"
    INCLUDE "includes/joypad_read_and_check.asm"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
