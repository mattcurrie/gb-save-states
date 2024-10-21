; md5 7351daa3c0a91d8f6fe2fbcca6182478

; ROMBANKS 64
; ROM "Legend of Zelda, The - Link's Awakening DX (U) (V1.2) [C][!].gbc"


; config
DEF is_cgb EQU 1
DEF current_rom_bank EQU $dbaf
DEF game_uses_save_ram EQU 1
DEF uses_mbc5 EQU 1


; joypad
DEF joypad EQU $ffcb
DEF joypad_2 EQU $ffcc
DEF swap_joypad EQU 1

SECTION "relocated read from joypad", ROM0[$0006]  ; note: manually changed to skip rom debug tool bytes at $0003-$0005 ; length: $003a
    INCLUDE "includes/relocated_read_from_joypad.asm"
ENDSECTION

SECTION "joypad read", ROM0[$2879] ; length: 4
    call relocated_read_from_joypad
    nop
ENDSECTION


; save/load state
SECTION "save/load state", ROMX[$7CF5], BANK[$0002] ; length: $0295
    DB "--- Save Patch ---"
    INCLUDE "includes/save_state_includes.asm"
ENDSECTION


; Generated with patch-builder.py
