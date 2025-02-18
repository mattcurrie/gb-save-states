; md5 e91fd46e7092d32ca264f21853f09539

; ROMBANKS 64
; ROM "Legend of Zelda, The - Link's Awakening DX (G) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $dbaf
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ffcb
DEF joypad_2 EQU $ffcc
DEF swap_joypad EQU 1

SECTION "relocated read from joypad", ROM0[$0092] ; length: $40
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2868] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7cf5], BANK[$0002] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
